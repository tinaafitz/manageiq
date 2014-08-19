#
# Description: This method is executed when the service request is auto-approved
#

# get the request object from root
miq_request = $evm.root['miq_request']
log(:info, "miq_request.id:<#{miq_request.id}> miq_request.options[:dialog]:<#{miq_request.options[:dialog].inspect}>")

# lookup the service_template object
service_template = $evm.vmdb(miq_request.source_type, miq_request.source_id)
log(:info, "service_template id:<#{service_template.id}> service_type:<#{service_template.service_type}> description:<#{service_template.description}> services:<#{service_template.service_resources.count}>")

# Auto-Approve request
log(:info, "AUTO-APPROVING")
miq_request.approve("admin", "Auto-Approved")
