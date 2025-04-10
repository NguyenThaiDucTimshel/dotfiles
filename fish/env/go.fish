# Go (if go exists)
if command -vq go
    if not string match -q '*go\/libexec*' $PATH
        set -x GOPATH $HOME/go
        set -x GOROOT /usr/lib/go
        set -x PATH $GOPATH $PATH
        set -x PATH $GOPATH/bin $PATH
    end
end
