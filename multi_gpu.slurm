#!/bin/sh
#SBATCH --partition=GPUQ
#SBATCH --account=ie-idi
#SBATCH --time=60:00:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --mem=64000
#SBATCH --gres=gpu:A100m40:2
#SBATCH --job-name="multi_gpu_50_2"
#SBATCH --output=out_files/multi_gpu_50_2.out
#SBATCH --mail-user=henrfj@stud.ntnu.no
#SBATCH --mail-type=FAIL

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"

module purge
module load Anaconda/2020.07
python yolov5/train.py --img 800 --cfg yolov5s.yaml --hyp hyp.scratch-med.yaml --batch 32 --epochs 50 --data crddc2022.yaml --weights yolov5s.pt --workers 24 --name multi_gpu_50_2 --device 0,1

uname -a
