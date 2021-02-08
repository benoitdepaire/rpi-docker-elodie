# elodie-docker
## Description

An implementation of [elodie](https://github.com/jmathai/elodie) in a docker container, forked from the repository https://github.com/furiousgeorgecontainers/docker-elodie.

This container is meant to be run at the command-line. You can run elodie-stage.sh to move the files from ```/input``` folder to the ```/staged``` folder and ```elodie-publish.sh``` to move the files from the ```/staged``` folder to the ```/published``` folder.

The idea behind this two step approach is as follows:
- First we move a small set from the ```/import``` to the ```/staged``` folder to inspect the available EXIF information. If dates are missing or incorrect, we will easily detect this from the structure of the ```/staged``` folder. If so, we can correct the EXIF data using the ```update``` option of Elodie.
- Once the EXIF data is correct, we move the data from ```/staged``` to ```/published```. If the pictures already exist, they are skipped.

The folder structure used for both the ```/staged``` and ```/published``` folder is: ```/Year/Month```

## Directories

This docker container makes use of 3 directories:

* ```/config``` - The location of Elodie's configuration files
* ```/input```  - The location of your incoming images
* ```/output``` - The location Elodie will place processed images

These directories should be mounted to the corresponding directories on your host.  This is done by the scripts ```elodie-stage.sh``` and ```elodie-publish.sh```. A sample config file (```config.ini```) is also provided and should be copied to the ```config``` folder.

### Wrapper Script Execution

To run elodie in the docker container, just run the wrapper script and give it the arguments to pass to elodie in the container. You could make a simlink of the scripts to ```/usr/bin```. (```ln -s $PWD/elodie-stage.sh /usr/bin/elodie-stage```)

##### Usage

- create a separate config folder for both the stage and publish version on the host (```.../configs/Elodie/stage``` and ```.../configs/Elodie/stage```) and copy the ```config.ini``` file in this folder. Change the location of these folders appropriately at the top of the wrapper script.
- create an ```import```, ```staged``` and ```published``` folder on your host and map these to the ```/input``` and ```/output``` folders of the Docker container appropriately in the wrapper scripts
- Put the pictures you want to add in the ```import``` folder. Run ```elodie-stage```. Verify the structure in the ```staged``` folder. If necessary update the EXIF information.
- Run ```elodie-publish```. 
- Remove the .Trash-1000 folder and other remaining folders from the ```import``` and ```staged``` folders.

For full documentation on elodie's usage, see the [Usage section](https://github.com/jmathai/elodie#usage-instructions) in the Elodie repository.

## Some issues and how to resolve them
- If you have trouble running this docker and the date in the container seems to be completely off: https://serverfault.com/questions/1037146/docker-container-with-random-date
