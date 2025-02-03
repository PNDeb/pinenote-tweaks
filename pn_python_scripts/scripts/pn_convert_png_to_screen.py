#!/usr/bin/env python
"""

"""
import os
import argparse

from PIL import Image

import png
import array


def convert_to_pn(infile, outfile):
    # assumes that the png is 1872 x 1404, 8-bit grayscal
    print('Opening file: {}'.format(infile))
    reader = png.Reader(infile)
    width, height, values, info = reader.read_flat()
    bad_png = False
    if width != 1872:
        print('ERROR: input png width must be 1872 pixels')
        bad_png = True

    if height != 1404:
        print('ERROR: input png height must be 1404 pixels')
        bad_png = True

    if info['bitdepth'] != 8:
        print('ERROR: input png bitdepth must be 8')
        bad_png = True

    if not info['greyscale']:
        print('ERROR: input png must be grayscale')
        # bad_png = True
        print('Re-importing and converting using PIL...')
        values = Image.open(infile).convert('L').tobytes()

    if bad_png:
        return

    # import IPython
    # IPython.embed()
    # data = map(lambda x: map(int, x/17), values)
    out_array = array.array('b')
    out_array.fromlist([int(x / 17) for x in values])
    image_4bit = []
    for i in range(0, len(out_array), 2):
        image_4bit += [out_array[i] << 4 | out_array[i + 1]]

    print(len(image_4bit))
    assert len(image_4bit) == 1872 * 1404 / 2, \
        "Output file length not as expected"

    print('Writing 4-bit data to file: {}'.format(outfile))

    with open(outfile, 'wb') as fid:
        fid.write(bytes(image_4bit))


def handle_args():
    parser = argparse.ArgumentParser(prog='pn_convert_png_to_screen')
    parser.add_argument(
        '--png',
        '-i',
        help='PNG infile to convert',
        required=True,
        type=str
    )
    parser.add_argument(
        '--output',
        '-o',
        help='output binary file',
        default='output.bin',
    )

    args = parser.parse_args()
    return args


if __name__ == '__main__':
    args = handle_args()

    if not os.path.isfile(args.png):
        print('ERROR: Input file {} does not exist!'.format(args.png))
        exit()

    if os.path.isfile(args.output):
        print('ERROR: Output file already exists')
        exit()

    convert_to_pn(
        args.png,
        args.output
    )

    # convert_to_pn('feli_bert.png', 'feli_bert.bin')
    # convert_to_pn('pine.png', 'pine.bin')
    # convert_to_pn('spheres_rgb.png', 'spheres_bw.bin')
