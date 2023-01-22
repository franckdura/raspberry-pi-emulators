while getopts f: option
do 
    case "${option}"
        in
        f)force=${OPTARG};;
    esac
done

if  [[ $force = 1 ]]; then
    docker kill $(docker ps -q)
else
    docker stop raspi2b
    docker stop raspi3b
    docker stop raspi4bvirtio
    docker stop raspi4bphilmd
fi