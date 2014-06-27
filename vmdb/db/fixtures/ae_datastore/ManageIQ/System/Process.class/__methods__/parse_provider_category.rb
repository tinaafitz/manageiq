def dump_root
  $evm.log("info", "Root:<$evm.root> Attributes - Begin")
  $evm.root.attributes.sort.each { |k, v| $evm.log("info", "  Attribute - #{k}: #{v}") }
  $evm.log("info", "Root:<$evm.root> Attributes - End")
  $evm.log("info", "")
end

def vm_detect_category(vm)
  $evm.log("info", "VM OC: #{vm.object_class.inspect}")
  return nil unless vm.respond_to?(:cloud)
  vm.cloud == true ? 'cloud' : 'infrastructure'
end

def miq_request_detect_category(miq_request)
  $evm.log("info", "MiqRequest OC: #{miq_request.object_class.inspect}")
  vm_detect_category(miq_request.source)
end

def miq_provision_detect_category(miq_provision)
    $evm.log("info", "MiqProvision OC: #{miq_provision.object_class.inspect}")
    vm_detect_category(miq_provision.source)
end

def platform_category_detect_category(platform_category)
  platform_category = 'infrastructure' if platform_category == 'infra'
  platform_category
end

def category_for_key(key)
  send("#{key}_detect_category", $evm.root[key]) if $evm.root.attributes.key?(key)
end

$evm.log("info", "XXXX Parse Provider Category starting")

dump_root

key_found = %w(vm miq_request miq_provision platform_category).detect do |key|
  $evm.object['ae_provider_category'] = category_for_key(key)
end

$evm.log("info", "Parse Provider Category Key: #{key_found.inspect}")

$evm.object['ae_provider_category'] = "unknown" if key_found.nil?
$evm.root['ae_provider_category']   = $evm.object['ae_provider_category']

dump_root
$evm.log("info", "XXXX Parse Provider Category ending")
