# Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# This file is licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License. A copy of the
# License is located at
#
# http://aws.amazon.com/apache2.0/
#
# This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
# OF ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'aws-sdk-s3'  # In v2: require 'aws-sdk'

require 'base64'
require 'openssl'

region = 'us-west-2'
bucket_name = 'my_bucket'
item = 'my_item'
pk_file = 'public_key_file.pem'

client = Aws::S3::Client.new(region: region)

# Get file content as string
file = File.open(item, "rb")
contents = file.read
file.close

public_key = OpenSSL::PKey::RSA.new(File.read(pk_file))
encrypted_string = Base64.encode64(public_key.public_encrypt(contents))

resp = client.put_object({
  body: encrypted_string,
  bucket: bucket_name,
  key: name,
})

puts 'Added encrypted item to bucket'
