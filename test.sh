package="neuropixels-pxi_windows"
RELEASE_VERSION="0.1.0"
build_dir="Build/Release"
plugin_api=$(grep -rnw ../../plugin-GUI/Source -e '#define PLUGIN_API_VER' | grep -Eo "[0-9]*" | tail -1)
new_plugin_ver=$RELEASE_VERSION-API$plugin_api
echo "New plugin version: $new_plugin_ver"
out_dir=$build_dir/${package}_${new_plugin_ver}
mkdir $out_dir
mkdir $out_dir/plugins
cp -v $build_dir/*.dll $out_dir/plugins
if [ -d "Resources" ]
then
  mkdir "$out_dir/shared"
  cp -v Resources/*.dll "$out_dir/shared"
else
  echo "No resources to copy"
fi
zipfile=${package}_${new_plugin_ver}.zip
powershell Compress-Archive -Path ${out_dir} ${zipfile}