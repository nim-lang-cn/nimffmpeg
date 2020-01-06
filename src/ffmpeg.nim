import os

const source = currentSourcePath.parentDir()
const includepath = "-I" & (source / "../cinclude")
{.passC: includepath.}

import ffmpeg/utiltypes

import ffmpeg/libavcodec/[avcodec, ac3_parser, adts_parser, avdct,
                          avfft, dirac, dv_profile, jni,
                          mediacodec, vorbis_parser]

when defined(windows):
  import ffmpeg/libavcodec/[d3d11va, dxva2]
else:
  import ffmpeg/libavcodec/[vaapi, vdpau, xvmc]

import ffmpeg/libavdevice/avdevice

#add libavfilter import

import ffmpeg/libavformat/[avformat, avio]

import ffmpeg/libavutil/[log, avutil, common, dict, frame, hwcontext,
                         opt, pixdesc, pixfmt, rational, samplefmt,
                         channel_layout, avconfig, buffer, adler32,
                         aes, aes_ctr, imgutils]

#add libpostproc import

import ffmpeg/libswresample/swresample

import ffmpeg/libswscale/swscale

export utiltypes

export avcodec, ac3_parser, adts_parser, avdct,
       avfft, dirac, dv_profile, jni,
       mediacodec, vorbis_parser

when defined(windows):
  export d3d11va, dxva2
else:
  export vaapi, vdpau, xvmc

export avdevice

export avformat, avio

export log, avutil, common, dict, frame, hwcontext,
       opt, pixdesc, pixfmt, rational, samplefmt,
       channel_layout, avconfig, buffer, adler32,
       aes, aes_ctr, imgutils

export swresample

export swscale