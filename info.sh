#!/bin/bash
echo "Content-type: text/html"
echo ""
rawJson=`curl -s --user 0e4c9336-ffa8-4358-b9e9-8c9bed7d41da:z7GS7nL9E3sqPPc6eE68seFEaRXwj6F6OwSg4c4WvLbJQ4zkaoIjjP4Zd6R2iJYt https://app.arukas.io/api/containers -H "Content-Type: application/vnd.api+json" -H "Accept: application/vnd.api+json" | jq '.data'`
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

