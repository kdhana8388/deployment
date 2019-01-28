echo "=== Deployment has started! ==="

::check input arguments
IF /I "%#%" EQU "0" 
echo "ERROR: Please, pass the filename for deployment descritor as an argument!"
    
ELSE

::#filename passed as script argument
SET filename="%1%"

::#Call Anypoint API to execute deployment and all the required configuration
echo '=== Invoke Anypoint API'
{ #try
	node .muleci/anypoint_deployment_cloud_api.js "%filename%"
	node .muleci/anypoint_deployment_arm_api.js "%filename%"
} || { #catch
	echo "=== ERROR: Error during deployment"
	exit 1
}

echo "=== Deployment has finished successfully! ==="