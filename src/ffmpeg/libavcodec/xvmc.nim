##
##  Copyright (C) 2003 Ivan Kalvachev
##
##  This file is part of FFmpeg.
##
##  FFmpeg is free software; you can redistribute it and/or
##  modify it under the terms of the GNU Lesser General Public
##  License as published by the Free Software Foundation; either
##  version 2.1 of the License, or (at your option) any later version.
##
##  FFmpeg is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
##  Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public
##  License along with FFmpeg; if not, write to the Free Software
##  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
##

## *
##  @file
##  @ingroup lavc_codec_hwaccel_xvmc
##  Public libavcodec XvMC header.
##

#import libavutil/attributes, version, avcodec

## *
##  @defgroup lavc_codec_hwaccel_xvmc XvMC
##  @ingroup lavc_codec_hwaccel
##
##  @{
##

const
  AV_XVMC_ID* = 0x1DC711C0

{.pragma: xvmc, importc, header: "<X11/extensions/XvMC.h>".}

## struct attribute_deprecated xvmc_pix_fmt {

type
  XvMCMacroBlock* {.xvmc.} = object
  XvMCSurface* {.xvmc.} = object
  xvmc_pix_fmt* {.importc, header: "<libavcodec/xvmc.h>", deprecated.} = object
    xvmc_id*: cint ## * The field contains the special constant value AV_XVMC_ID.
                 ##         It is used as a test that the application correctly uses the API,
                 ##         and that there is no corruption caused by pixel routines.
                 ##         - application - set during initialization
                 ##         - libavcodec  - unchanged
                 ##
    ## * Pointer to the block array allocated by XvMCCreateBlocks().
    ##         The array has to be freed by XvMCDestroyBlocks().
    ##         Each group of 64 values represents one data block of differential
    ##         pixel information (in MoCo mode) or coefficients for IDCT.
    ##         - application - set the pointer during initialization
    ##         - libavcodec  - fills coefficients/pixel data into the array
    ##
    data_blocks*: ptr cshort ## * Pointer to the macroblock description array allocated by
                          ##         XvMCCreateMacroBlocks() and freed by XvMCDestroyMacroBlocks().
                          ##         - application - set the pointer during initialization
                          ##         - libavcodec  - fills description data into the array
                          ##
    mv_blocks*: ptr XvMCMacroBlock ## * Number of macroblock descriptions that can be stored in the mv_blocks
                                ##         array.
                                ##         - application - set during initialization
                                ##         - libavcodec  - unchanged
                                ##
    allocated_mv_blocks*: cint ## * Number of blocks that can be stored at once in the data_blocks array.
                             ##         - application - set during initialization
                             ##         - libavcodec  - unchanged
                             ##
    allocated_data_blocks*: cint ## * Indicate that the hardware would interpret data_blocks as IDCT
                               ##         coefficients and perform IDCT on them.
                               ##         - application - set during initialization
                               ##         - libavcodec  - unchanged
                               ##
    idct*: cint ## * In MoCo mode it indicates that intra macroblocks are assumed to be in
              ##         unsigned format; same as the XVMC_INTRA_UNSIGNED flag.
              ##         - application - set during initialization
              ##         - libavcodec  - unchanged
              ##
    unsigned_intra*: cint ## * Pointer to the surface allocated by XvMCCreateSurface().
                        ##         It has to be freed by XvMCDestroySurface() on application exit.
                        ##         It identifies the frame and its state on the video hardware.
                        ##         - application - set during initialization
                        ##         - libavcodec  - unchanged
                        ##
    p_surface*: ptr XvMCSurface ## * Set by the decoder before calling ff_draw_horiz_band(),
                             ##     needed by the XvMCRenderSurface function.
                             ## @{
                             ## * Pointer to the surface used as past reference
                             ##         - application - unchanged
                             ##         - libavcodec  - set
                             ##
    p_past_surface*: ptr XvMCSurface ## * Pointer to the surface used as future reference
                                  ##         - application - unchanged
                                  ##         - libavcodec  - set
                                  ##
    p_future_surface*: ptr XvMCSurface ## * top/bottom field or frame
                                    ##         - application - unchanged
                                    ##         - libavcodec  - set
                                    ##
    picture_structure*: cuint ## * XVMC_SECOND_FIELD - 1st or 2nd field in the sequence
                            ##         - application - unchanged
                            ##         - libavcodec  - set
                            ##
    flags*: cuint ## }@
                ## * Number of macroblock descriptions in the mv_blocks array
                ##         that have already been passed to the hardware.
                ##         - application - zeroes it on get_buffer().
                ##                         A successful ff_draw_horiz_band() may increment it
                ##                         with filled_mb_block_num or zero both.
                ##         - libavcodec  - unchanged
                ##
    start_mv_blocks_num*: cint ## * Number of new macroblock descriptions in the mv_blocks array (after
                             ##         start_mv_blocks_num) that are filled by libavcodec and have to be
                             ##         passed to the hardware.
                             ##         - application - zeroes it on get_buffer() or after successful
                             ##                         ff_draw_horiz_band().
                             ##         - libavcodec  - increment with one of each stored MB
                             ##
    filled_mv_blocks_num*: cint ## * Number of the next free data block; one data block consists of
                              ##         64 short values in the data_blocks array.
                              ##         All blocks before this one have already been claimed by placing their
                              ##         position into the corresponding block description structure field,
                              ##         that are part of the mv_blocks array.
                              ##         - application - zeroes it on get_buffer().
                              ##                         A successful ff_draw_horiz_band() may zero it together
                              ##                         with start_mb_blocks_num.
                              ##         - libavcodec  - each decoded macroblock increases it by the number
                              ##                         of coded blocks it contains.
                              ##
    next_free_data_block_num*: cint


## *
##  @}
##
