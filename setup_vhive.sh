git clone --depth=1 https://github.com/vhive-serverless/vhive.git
cd vhive
mkdir -p /tmp/vhive-logs
./scripts/cloudlab/setup_node.sh stock-only  # this might print errors, ignore them
sudo screen -d -m containerd
./scripts/cluster/create_one_node_cluster.sh stock-only

cd ..
git clone --branch=words_sosp23_tutorial https://github.com/vhive-serverless/invitro.git
kubectl patch configmap/config-autoscaler -n knative-serving -p '{"data":{"allow-zero-initial-scale":"true"}}'
kubectl patch configmap/config-autoscaler -n knative-serving -p '{"data":{"initial-scale":"0"}}'

pushd invitro
git lfs install
git lfs fetch
git lfs checkout
sudo apt install -y pip
pip install -r requirements.txt
wget https://azurecloudpublicdataset2.blob.core.windows.net/azurepublicdatasetv2/azurefunctions_dataset2019/azurefunctions-dataset2019.tar.xz -P ./data/azure
pushd data/azure
tar -xvf azurefunctions-dataset2019.tar.xz
popd