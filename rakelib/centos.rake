task :centos do
  sh("yum install ...")
  cp_rf Dir["input/rpm/*"], "output/rpm/"

  sh(%Q{rpm --addsign --define '_gpg_name #{ENV["GPG_SIGNING_KEY_ID"}' /output/*.rpm})
  sh(%Q{gpg --armor --output /tmp/GPG-KEY-GOCD --export #{ENV['GPG_SIGNING_KEY_ID']}})
  sh("rpm --import /tmp/GPG-KEY-GOCD")
  sh("rpm --checksig /signed/*.rpm")
end
