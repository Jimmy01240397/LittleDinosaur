import sys

if len(sys.argv) < 4:
    print("usage: " + sys.argv[0] + " <filename> <width> <height>")
    exit(1)

def shrink(image, new_width, new_height):
    # Determine the original width and height of the image
    image = [i.strip() for i in image]

    original_width = len(image[0])
    original_height = len(image)

    # Create the new image with the desired width and height
    new_image = [list('0'*new_width) for i in range(new_height)]

    # Iterate through each pixel in the new image
    for y in range(new_height):
        for x in range(new_width):
            # Calculate the corresponding pixel in the original image
            original_x = int(x * original_width / new_width)
            original_y = int(y * original_height / new_height)

            # Set the pixel in the new image to the value of the corresponding pixel in the original image
            new_image[y][x] = image[original_y][original_x]

    # Return the new image
    new_image = ["".join(i) for i in new_image]
    return new_image



with open(sys.argv[1], 'r') as f:
    data = f.readlines()

width = int(sys.argv[2])
height = int(sys.argv[3])

data = shrink(data, width, height)
for a in data:
    print(a)
