DIR="${HOME}/.kube"

# if kubectl is in PATH / installed
if which kubectl &>/dev/null; then
  [ -d "${DIR}" ] || mkdir -p "${DIR}"

  # Configure kubectl for local microk8s
  if ! [ -f "${DIR}/microk8s.config" ]; then
    # if microk8s is in PATH / installed
    if which microk8s &>/dev/null; then
      umask 0077
      microk8s config | sed 's/\(user\|name\): admin/\1: microk8s-admin/' > "${DIR}/microk8s.config"
    fi
  fi

  # setup kubectl
  KUBECONFIG="$(find $DIR \( -name 'config' -o -name '*.config' \) \( -type f -o -type l \) -print0 | tr '\0' ':')"
  KUBECONFIG="${KUBECONFIG%:}"
  export KUBECONFIG
fi
