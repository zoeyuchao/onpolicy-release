#!/bin/sh
env="GridWorld"
scenario="MiniGrid-Human-v0"
num_agents=2
num_preies=2
num_obstacles=2
algo="rmappo"
exp="debug"
seed_max=1

echo "env is ${env}, scenario is ${scenario}, algo is ${algo}, exp is ${exp}, max seed is ${seed_max}"
for seed in `seq ${seed_max}`;
do
    let "seed=$seed+1"
    echo "seed is ${seed}:"
    CUDA_VISIBLE_DEVICES=0 python train/train_gridworld.py --direction_alpha 0.5 \
    --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} --scenario_name ${scenario} \
    --use_wandb --user_name "zoeyuchao" --num_agents ${num_agents} --num_preies ${num_preies} \
    --num_obstacles ${num_obstacles} --cnn_layers_params '32,3,1,1' --seed 1 --n_training_threads 1 \
    --n_rollout_threads 1 --num_mini_batch 1 --num_env_steps 2000000 --ppo_epoch 10 --gain 0.01 \
    --lr 7e-4 --critic_lr 7e-4
done
