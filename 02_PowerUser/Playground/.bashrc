            __main() {
                local major="${BASH_VERSINFO[0]}"
                local minor="${BASH_VERSINFO[1]}"

                if ((major > 4)) || { ((major == 4)) && ((minor >= 1)); }; then
                    source <("/nix/store/lcsz92qfxpr4dqnpg9c72mirrkdy5sqy-starship-0.54.0/bin/starship" init bash --print-full-init)
                else
                    source /dev/stdin <<<"$("/nix/store/lcsz92qfxpr4dqnpg9c72mirrkdy5sqy-starship-0.54.0/bin/starship" init bash --print-full-init)"
                fi
            }
            __main
            unset -f __main