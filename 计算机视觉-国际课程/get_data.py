import os
import cv2

save_path = './data/images'
if not os.path.isdir(save_path):
    os.mkdir(save_path)

name_list = ['Aaron Hernandez',
            'Aaron Rodgers',
            'Abhishek Bachchan',
            'Adam Levine',
            'Adam Sandler',
            'Adrian Gonzalez',
            'Adrian Peterson',
            'Aishwarya Rai',
            'Ajay Devgan',
            'Akshay Kumar',
            'Al Pacino',
            'Albert Pujol',
            'Alex Fergusson',
            'Alex Morgan',
            'Alex Rodriguez',
            'Alexis Sanchez',
            'Alicia Keys',
            'Allen Iverson',
            'Allyson Felix',
            'Alvaro Uribe',
            'Alyson Hannigan',
            'Alyssa Milano',
            'Amanda Seyfried',
            'Amar Stoudemire',
            'Amber Heard',
            'Amir Khan',
            'Amitabh Bachchan'
             ]

all_file = os.listdir('./datasets/cfp-dataset/Data/Images')
root_path = './datasets/cfp-dataset/Data/Images'
for i, file in enumerate(all_file):
    name_index = str(i + 1).zfill(3)
    main_faces = os.listdir(os.path.join(root_path, name_index, 'frontal'))
    side_faces = os.listdir(os.path.join(root_path, name_index, 'profile'))
    for main_face in main_faces:
        img = cv2.imread(os.path.join(root_path, name_index, 'frontal', main_face))
        cv2.imwrite(os.path.join(save_path, name_index + 'f' + main_face), img)
    for side_face in side_faces:
        img = cv2.imread(os.path.join(root_path, name_index, 'profile', side_face))
        cv2.imwrite(os.path.join(save_path, name_index + 'p' + side_face), img)
    try:
        name = name_list[i]
    except:
        break