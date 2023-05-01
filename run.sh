#!/bin/bash

steps=2
for i in {5000000..5049990..2}
do
   start=$i
   end=$((i+1))
   echo $start $end
   idx=0
   while [[ $start -le $end ]]
   do
      if [ -f "output/pp-$start.json" ]; 
      then      
        echo "File $start is already presenti, so skipping it"
      else
        echo $start
        ./predict --rpc https://rpc.ftm.tools/  --timeout 15 --batch 50 --block $start --out output/pp &
        pids[$idx]=$!
      fi
      ((idx=idx+1))
      ((start=start+1))
   done

   for pid in ${pids[*]}; do
      wait $pid
   done
done
