#include "qthumbnail.h"

#include <QImage>
#include <QString>
#include <QDebug>

extern "C" {
#include <libavformat/avformat.h>
#include <libavcodec/avcodec.h>
#include <libswscale/swscale.h>
#include <libswresample/swresample.h>
}

QThumbnail::QThumbnail(QObject *parent)
{

}


QImage QThumbnail::createThumbnail(const QString &path,int width){

    AVFormatContext* fmt_ctx_ = nullptr;

    //使用ByteArray切换
    QByteArray ba = path.toLocal8Bit();
    const char *cPath = ba.data();

    //open file
    int errCode = avformat_open_input(&fmt_ctx_, cPath, nullptr, nullptr);
    if(errCode != 0){
        qDebug() << "open file fail" << errCode;
        exit(1);
    }

    //read video stream
    errCode = avformat_find_stream_info(fmt_ctx_, nullptr);
    if(errCode != 0){
        qDebug() << "avformat_find_stream_info fail" << errCode;
        avformat_close_input(&fmt_ctx_);
        exit(1);
    }

    //test video meta info
//    av_dump_format(fmt_ctx_, 0, cPath, 0);
//    qDebug()<<"test\t";

    AVPacket* pkt = av_packet_alloc();
    AVFrame* temp_frame = av_frame_alloc();
    SwsContext* sws_ctx = nullptr;
//    int64_t timestamp = targetTime * AV_TIME_BASE;
    int ret = 0;

    QImage thumbnail;
    bool createDone = false;

    int videoStream = 0;

    for (int i=0; i<int(fmt_ctx_->nb_streams) && !createDone; i++){
        //only video data
        if (fmt_ctx_->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO) {
            //find codec
            videoStream = i;
            const AVCodec* codec = avcodec_find_decoder(fmt_ctx_->streams[i]->codecpar->codec_id);
            AVCodecContext *codec_ctx = avcodec_alloc_context3(codec);

            avcodec_parameters_to_context(codec_ctx, fmt_ctx_->streams[i]->codecpar);

            avcodec_open2(codec_ctx, codec, nullptr);

            //find frame
            while (av_read_frame(fmt_ctx_, pkt) >= 0){
                if (pkt->stream_index == videoStream) {

                    av_frame_unref(temp_frame);

                    //deal with frame
                    while ((ret = avcodec_receive_frame(codec_ctx, temp_frame)) == AVERROR(EAGAIN)){
                        ret = avcodec_send_packet(codec_ctx, pkt);

                        if (ret < 0) {
                            qCritical() << "Failed to send packet to decoder." << ret;
                            break;
                        }
                    }

                    if(ret < 0 && ret != AVERROR_EOF){
                        qDebug() << "Failed to receive packet from decoder." << ret;
                        continue;
                    }


                    //proportional scaling
                    int dstH = width;
                    int dstW = qRound(dstH * (float(temp_frame->width)/float(temp_frame->height)));


                    sws_ctx = sws_getContext(
                        temp_frame->width,
                        temp_frame->height,
                        static_cast<AVPixelFormat>(temp_frame->format),
                        dstW,
                        dstH,
                        static_cast<AVPixelFormat>(AV_PIX_FMT_RGBA),
                        SWS_FAST_BILINEAR,
                        nullptr,
                        nullptr,
                        nullptr
                        );
                    int linesize[AV_NUM_DATA_POINTERS];
                    linesize[0] = dstW*4;

                    //create view
                    thumbnail = QImage(dstW, dstH, QImage::Format_RGBA8888);
                    uint8_t* data = thumbnail.bits();
                    sws_scale(sws_ctx,
                              temp_frame->data,
                              temp_frame->linesize,
                              0,
                              temp_frame->height,
                              &data,
                              linesize);
                    sws_freeContext(sws_ctx);

                    avcodec_close(codec_ctx);
                    avcodec_free_context(&codec_ctx);
                    createDone = true;
                    break;
                }
            }
        }
    }

    //close
    av_frame_free(&temp_frame);
    av_packet_free(&pkt);
    avformat_close_input(&fmt_ctx_);

    return thumbnail;
}
