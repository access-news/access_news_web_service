{ pkgs ? import ~/clones/nixpkgs {} }:

pkgs.mkShell {

  buildInputs = with pkgs; [
    beam.packages.erlangR21.elixir_1_9
    postgresql_11
    nodejs-12_x
    git
  ];

  shellHook = ''

    # Put the PostgreSQL databases in the project diretory.
    mkdir .nix-shell
    export NIX_SHELL_DIR=$PWD/.nix-shell
    export PGDATA=$NIX_SHELL_DIR/db

    if ! test -d $PGDATA
    then

      initdb $PGDATA

      OPT="unix_socket_directories"
      sed -i "s|^#$OPT.*$|$OPT = '$PGDATA'|" $PGDATA/postgresql.conf
    fi

    trap \
      " pg_ctl -D $PGDATA stop

        cd $PWD # otherwise it wont be able to delete stuff fromt the working dir
        rm -rf $NIX_SHELL_DIR
      " \
      EXIT

    pg_ctl -D $PGDATA -l $PGDATA/postgres.log  start

    export MIX_HOME="$NIX_SHELL_DIR/.mix"
    export MIX_ARCHIVES="$MIX_HOME/archives"

    if ! test -d $MIX_HOME
    then
      yes | mix local.hex
      yes | mix archive.install hex phx_new
    fi
  '';

  LOCALE_ARCHIVE = if pkgs.stdenv.isLinux then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
}
