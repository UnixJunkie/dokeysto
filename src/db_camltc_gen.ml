module Bdb = Camltc.Bdb

type filename = string

module RW (KV: Dokeysto.Db_gen.Key_val) = struct

  type t = Internal_camltc.db

  let create fn =
    Db_camltc.create fn

  let open_existing fn =
    Db_camltc.open_existing fn

  let dummy () =
    Db_camltc.dummy ()

  let sync db =
    Db_camltc.sync db

  let close db =
    Db_camltc.close db

  let destroy db =
    Db_camltc.destroy db

  let mem db k =
    Db_camltc.mem db (KV.string_of_key k)

  let find db k =
    Db_camltc.find db (KV.string_of_key k)

  let add db k v =
    Db_camltc.add db (KV.string_of_key k) (KV.string_of_value v)

  let replace db k v =
    Db_camltc.replace db (KV.string_of_key k) (KV.string_of_value v)

  let remove db k =
    Db_camltc.remove db (KV.string_of_key k)

  let iter f db =
    Db_camltc.iter (fun k_str v_str ->
        f (KV.key_of_string k_str) (KV.value_of_string v_str)
      ) db

  let fold f db init =
    Db_camltc.fold (fun k_str v_str acc ->
        f (KV.key_of_string k_str) (KV.value_of_string v_str) acc
      ) db init

end

module RO (KV: Dokeysto.Db_gen.Key_val) = struct

  type t = Internal_camltc.db

  let open_existing fn =
    Db_camltc.open_existing fn

  let dummy () =
    Db_camltc.dummy ()

  let close db =
    Db_camltc.close db

  let mem db k =
    Db_camltc.mem db (KV.string_of_key k)

  let find db k =
    Db_camltc.find db (KV.string_of_key k)

  let iter f db =
    Db_camltc.iter (fun k_str v_str ->
        f (KV.key_of_string k_str) (KV.value_of_string v_str)
      ) db

  let fold f db init =
    Db_camltc.fold (fun k_str v_str acc ->
        f (KV.key_of_string k_str) (KV.value_of_string v_str) acc
      ) db init

end
