#
# file: docker-build.sh 
#

start=$(date +%s)

# all image delete
#docker system prune -a -f

#docker build -t my-amazonlinux2-image .
docker build -t alinux:2.0.20230822.0 .


#
#
# タグが<none>のイメージIDを取得
#for image_id in $(docker images | awk '/<none>/ { print $3 }'); do
  # それぞれのイメージIDに関連するコンテナIDを取得
#  for container_id in $(docker ps -a -q --filter "ancestor=$image_id"); do
    # コンテナを強制削除
#    docker rm -f $container_id
#  done
#done

docker images

end=$(date +%s)
duration=$((end - start))

minutes=$((duration / 60))
seconds=$((duration % 60))

echo "The script took ${minutes}m ${seconds}s."
