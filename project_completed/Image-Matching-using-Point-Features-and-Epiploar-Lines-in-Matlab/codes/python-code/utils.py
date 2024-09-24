import numpy as np
import cv2
import matplotlib.pyplot as plt

def drawlines(img1, img2, lines, pts1, pts2, copy):
    if copy:
        img1, img2 = img1.copy(), img2.copy()

    H, W = img1.shape[0], img1.shape[1]

    for r, pt1, pt2 in zip(lines, pts1, pts2):
        color = tuple(np.random.randint(0, 255, 3).tolist())

        toCheck = [np.cross([0, 0, 1], [W, 0, 1]),
                   np.cross([0, 0, 1], [0, H, 1]),
                   np.cross([W, H, 1], [W, 0, 1]),
                   np.cross([W, H, 1], [0, H, 1])]

        isects = []
        for i in range(len(toCheck)):
            isect = np.cross(toCheck[i], r)
            isects.append(isect[:2] / isect[2])

        isects.sort(key=lambda v: np.linalg.norm(v - np.array([W / 2, H / 2])))
        x0, y0 = map(int, isects[0])
        x1, y1 = map(int, isects[1])

        img1 = cv2.line(img1, (x0, y0), (x1, y1), color, 3)
        img1 = cv2.circle(img1, tuple(map(int, pt1)), 5, color, -1)
        img2 = cv2.circle(img2, tuple(map(int, pt2)), 5, color, -1)

    return img1, img2

def draw_epipolar(img1, img2, F, pts1, pts2, filename=None, copy=True):
    # Builtin Function from OpenCV Library
    lines1 = cv2.computeCorrespondEpilines(pts2.reshape(-1, 1, 2), 2, F)
    lines1 = lines1.reshape(-1, 3)

    img1_with_lines, _ = drawlines(img1, img2, lines1, pts1, pts2, copy)
    # Builtin Function from OpenCV Library
    lines2 = cv2.computeCorrespondEpilines(pts1.reshape(-1, 1, 2), 1, F)
    lines2 = lines2.reshape(-1, 3)

    img2_with_lines, _ = drawlines(img2, img1, lines2, pts2, pts1, copy)

    plt.subplot(121)
    plt.imshow(img1_with_lines)
    plt.title("Image 1 epipolar lines")

    plt.subplot(122)
    plt.imshow(img2_with_lines)
    plt.title("Image 2 epipolar lines")

    if filename is None:
        plt.show()
    else:
        plt.show(block=False)
        plt.savefig(filename)
        plt.pause(0.5)
        plt.close()