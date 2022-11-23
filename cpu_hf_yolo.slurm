#!/bin/sh
#SBATCH --partition=CPUQ
#SBATCH --account=ie-idi
#SBATCH --time=30:00:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=4
#SBATCH --mem=64000
#SBATCH --job-name="cpu_hf_yolo"
#SBATCH --output=cpu_hf_yolo.out
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
python yolov5/train.py --img 1000 --cfg yolov5s.yaml --hyp hyp.scratch-med.yaml --batch 128 --epochs 10 --data crddc2022.yaml --weights yolov5s.pt --workers 24 --name cpu_test_run --device cpu

uname -a
