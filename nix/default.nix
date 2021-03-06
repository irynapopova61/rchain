let

  pkgs = import <nixpkgs> {};

  bnfcSrc = pkgs.fetchFromGitHub {
              owner = "BNFC";
              repo = "bnfc";
              rev = "7c9e8591902c806c17cc5617db228e5f3e02a2ad";
              sha256 = "18rr41kabb9dabmaz58k1iyv1ijv9aq0gzg1jyal3nicpmm9159a";
              postFetch = ''
                tar --strip-components=1 -xvzf $downloadedFile
                mkdir $out
                cp -r source/* $out
              '';
            };

  bnfcHEAD = pkgs.haskellPackages.callCabal2nix "bnfc-HEAD" bnfcSrc {};

in {

  bnfc = bnfcHEAD;

  rchainPackages = with pkgs; [ bnfcHEAD jflex ];
}
