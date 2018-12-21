#! /bin/sh
#
# @author Łukasz Buśko
# @email busko.lukasz@pm.me or buskol.waw.pl@gmail.com
# @license gpl v3
#

PWD=$(pwd)
CODEC=libx265
#fast medium slow veryslow, depends on machine capabilities and input quality
CODEC_OPTIONS="-preset medium -x265-params"
CRF=24

function print_help {
    echo "Available help:"
    echo "-h | --help print this message"
    echo "-p | --path change work path, default: ${PWD}"
    echo "-q | --quality level 0-best, 24 - (20 gopro h264), default: ${CRF}"
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        -h | --help)
            print_help
            exit 0
        ;;
        -p | --path)
            PWD=$2
            shift
        ;;
        -q | quality)
            CRF=$2
            shift
        ;;
        *)
            print_help
            exit 1
        ;;
    esac
    shift
done

for file in $(find ${PWD} -type f -name \*.MP4); do
    ffmpeg -i $file -c:v ${CODEC} ${CODEC_OPTIONS} crf=${CRF} -c:a copy "${file%.*}".mp4
done;
