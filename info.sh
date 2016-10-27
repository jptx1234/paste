#!/bin/bash
echo "Content-type: text/html"
rawJson=`curl -s -n https://app.arukas.io/api/containers -H "Content-Type: application/vnd.api+json" -H "Accept: application/vnd.api+json" | jq '.data'`
length=`echo $rawJson | jq "length"`
addr="lost"
port="0"
aimAddr="\"jptxss.arukascloud.io\""
aimPort="6800"
for((i=0;i<$length;i++)) ; do
	endP=`echo $rawJson | jq ".[$i].attributes.end_point"`
	if [ "$endP" = "$aimAddr" ] ; then
		portMapping=`echo $rawJson | jq ".[$i].attributes.port_mappings|.[0]"`
		portMappingLength=`echo $portMapping | jq "length"`
		for((j=0;j<$portMappingLength;j++)) ; do
			cPortJson=`echo $portMapping | jq ".[$j]"`
			cPort=`echo $cPortJson | jq ".container_port"`
			if [ "$cPort" = "$aimPort" ] ; then
				port=`echo $cPortJson | jq ".service_port"`
				addr=`echo $cPortJson | jq ".host" | awk -F '"' '{printf $2}'`
				addr=`host $addr | awk -F 'address ' '{printf $2}'`
				break 2
			fi
		done
	fi
done
echo "$addr:$port"

