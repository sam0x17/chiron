require "spec"
ENV["VERBOSE"] = "false"
require "../src/chiron"

TEST_DIR = "/tmp/chiron-test-dir"

def refresh_test_dir
  FileUtils.mkdir_p(TEST_DIR)
  FileUtils.rm_rf(TEST_DIR)
  FileUtils.mkdir_p(TEST_DIR)
end
