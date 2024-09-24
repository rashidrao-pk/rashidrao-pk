import os

from utils import *

def findPairs(img1, img2, num_pairs = 8):
    orb = cv2.ORB_create()
    # Built-in Function for Detecting Points
    keypoints1, descriptor1 = orb.detectAndCompute(img1, None)
    keypoints2, descriptor2 = orb.detectAndCompute(img2, None)
    # Built-in Function for Points Matching
    matches = cv2.BFMatcher_create().match(descriptor1, descriptor2)
    # Built-in Function for Sorting of Points
    matches = sorted(matches, key = lambda m: m.distance)

    pts1 = []
    pts2 = []

    for m in matches[:num_pairs]:
        pts1.append(keypoints1[m.queryIdx].pt)
        pts2.append(keypoints2[m.trainIdx].pt)
    return np.asarray(pts1), np.asarray(pts2)

def run(fn1, fn2, out_folder):
    # Making Directory for Writing Results if not existing
    if not os.path.isdir(out_folder):
        os.makedirs(out_folder)

    img1 = cv2.imread(fn1)
    img2 = cv2.imread(fn2)

    img1 = cv2.resize(img1, (512, 512))
    img2 = cv2.resize(img2, (512, 512))

    img1_gray = cv2.cvtColor(img1, cv2.COLOR_BGR2GRAY)
    img2_gray = cv2.cvtColor(img2, cv2.COLOR_BGR2GRAY)
    # User Defined Function No 1
    pts1, pts2 = findPairs(img1_gray, img2_gray)
    # Second Requirments
    # Built-in Function from  OpenCV Library
    F, _ = cv2.findFundamentalMat(pts1, pts2, cv2.FM_RANSAC)

    if F is not None:
        # Built-in Function from  Numpy Library to save Fun Matrix Values to a text file
        np.savetxt(os.path.join(out_folder, 'FMat.txt'), F, delimiter=',')
        # User Defined Function
        draw_epipolar(img1, img2, F, pts1, pts2, filename=os.path.join(out_folder, 'epipolars.jpg'))
    # Built-in Function for Horizontal Stacking of two images into a single image
    out_img = np.hstack([img1, img2])
    for pt1, pt2 in zip(pts1, pts2):
        pt1, pt2 = pt1.astype(np.int_), pt2.astype(np.int_)
        cv2.line(out_img, pt1, pt2 + np.array([512, 0]), (0, 0, 255))
    # Writing Images to Out Folder having Matched Points plotted onto Stacked Image
    cv2.imwrite(os.path.join(out_folder, 'matches.jpg'), out_img)

if __name__ == '__main__':
    in_path = 'input_images'
    out_path = 'outputs'

    for pair_dir in os.listdir(in_path):
        img_fns = [os.path.join(in_path, pair_dir, fn) for fn in os.listdir(os.path.join(in_path, pair_dir))]
        # Checking if the folder is having two images or not
        assert len(img_fns) == 2, 'Only 2 images are expected'

        out_folder = os.path.join(out_path, pair_dir)
        # Calling User Defined Function 'Run' for further utilization
        run(*img_fns, out_folder)
        # Showing Progress
        print(pair_dir , 'Done')