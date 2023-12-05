# 《计算机视觉》
### File declaration
+ get_data.py: Rename the image. Since the downloaded dataset contains duplicate image names, use this code to rename the image and divide the used image into a folder for easy labeling using labelimg
+ yolov5/Depose.py: The running code file of the project, just run it directly
+ GUI_Study: This folder contains some of the learning code of the Tkinter library
+ datasets: This folder is the official CFP dataset. Since the memory of this dataset is large and it is not convenient to send, the download link is given: http://www.cfpw.io/
+ data: This folder contains the dataset used for training in this project
+ record: This folder contains screenshots from training

### Additional details
Since the weight file occupies a large amount of memory, the pre-training weights and the weights obtained by training are deleted: runs/detect/exp2/weights/best.pt and last.pt
However, the weight file for project presentation is retained, located at: yolov5/best.pt

### Instructions
1. Configuration environment: 

     pip install -r requirements.txt
2. Train the network to obtain the weight and run the code:
     
     python train.py --data face-27.yaml --weights yolov5m.pt --epochs 200 --batch-size 2 --img 640
3. Obtain the corresponding weight:
     
     Corresponding file location: runs/train/exp2/weights/best.pt
4. Run the code after the configuration is completed:

     cd yolov5

     python Depose.py
### Demo video
Due to the video file is too large, it is stored in Baidu web disk.

Link: https://pan.baidu.com/s/1VA7HZf5bRF9V1sn6_o3PQw?pwd=otsr

password: otsr