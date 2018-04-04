Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"gnSeur!LWTJDuPfQ8``nQfhZ8Uaf@/J`xg7AUXdZseMS>pSQdQsVqnnV3G7@~sD:"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"w*OqKmuvBwxYBCwkYBS:)P*S(16Kuf`8@`Ms)D|Pxqw;Px]tEJ*OLt}[N2,2NFM3"
end

release :my_cluster do
  set vm_args: "rel/vm.args"
  set version: current_version(:my_cluster)
  set applications: [
    :runtime_tools
  ]
end

