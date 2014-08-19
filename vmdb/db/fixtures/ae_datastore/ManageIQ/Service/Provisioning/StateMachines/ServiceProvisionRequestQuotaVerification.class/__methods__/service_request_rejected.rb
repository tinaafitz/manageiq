#
# Description: This method runs when the service request quota validation has failed
#

# Deny the request
$evm.log("info", "Request denied because of Quota")
$evm.root["miq_request"].deny("admin", "Quota Exceeded")
