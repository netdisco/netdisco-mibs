  # How to make an agentic PR for new or updated MIBs

  - Determine the required MIB file or archive.
  - Use a development environment meeting the requirements below.
  - Follow https://github.com/netdisco/netdisco-mibs/wiki/Updating-MIBs.
    Apply its installation and global configuration steps only inside an
    isolated environment; use equivalent command-scoped configuration when
    working with native tools.
  - Reiterate the essential workflow and validation steps in the commit message.
  - On success, create a pull request in https://github.com/netdisco/netdisco-mibs.

  ## Development environment

  EXTRAS/contrib/Dockerfile provides the recommended local toolset. Docker
  is optional. An existing disposable container, VM, or harness environment
  is equally acceptable if it meets these requirements. Nested Docker is
  not required.

  Already-installed native tools may also be used with a separate clone
  and command-scoped configuration.

  - Inspect the tools and repository state first. Preserve existing user work.
  - Install dependencies and change global Git or Net-SNMP configuration
    only inside the disposable environment. Host package installation,
    sudo, and host configuration changes require explicit user authorization.
  - Use a separate clone for the MIB workflow. Keep its Git configuration,
    LFS hooks, caches, and generated indexes separate from the user's checkout.
  - Treat writable host mounts as host access, regardless of sandbox type.
    Never mount the user's checkout writable into a root container.
  - If a writable host mount is necessary, run as the invoking user's UID/GID.
    Matching ownership alone does not isolate hooks, configuration, or files.
  - Keep credentials out of images and build contexts. Use an existing
    authorized publishing mechanism; do not copy private keys into images.
  - Verify Git LFS support before transferring results or publishing.
    Upload report objects along with their committed LFS pointers.
  - Transfer only reviewed task changes to the user's checkout, not
    development configuration, hooks, or caches.
  - Before finishing, verify file ownership and permissions, normal Git
    operation, and the final diff. Report persistent environment changes.
  - Remove temporary resources only after results have been published or
    safely preserved.
  - If these requirements cannot be met, explain the missing capability
    before making host-level changes.
