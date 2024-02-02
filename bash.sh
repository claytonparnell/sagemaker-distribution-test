versions=("{\"version\":[")
for major in build_artifacts/v*; do
  highest_minor=$(ls $major | sort -t. -k2n | tail -n1)
  highest_patch=$(ls $major/$highest_minor | sort -t. -k2n | tail -n1)
  versions+="\"${highest_patch#v}\""
  versions+=","
done
versions=${versions::-1}
versions+="]}"
echo $versions
