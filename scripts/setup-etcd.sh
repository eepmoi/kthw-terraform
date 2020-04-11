masters=$1
for instance in $(echo $masters | tr ',' ' '); do
  ZONE=`gcloud compute instances list | grep ${instance} | awk '{ print $2 }'`
  gcloud compute scp --zone=$ZONE --internal-ip bootstrap-etcd.sh ${instance}:~/
  gcloud compute ssh --zone=$ZONE --internal-ip ${instance} -- "cd ~/ && sh -x bootstrap-etcd.sh"
done
