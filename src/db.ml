
module Ht = Hashtbl

type filename = string

let string_of_key (k: 'a): string =
  Marshal.(to_string k [No_sharing])

let string_of_value (v: 'b): string =
  Marshal.(to_string v [No_sharing])

let key_of_string (k_str: string): 'a =
  (Marshal.from_string k_str 0: 'a)

let value_of_string (v_str: string): 'b =
  (Marshal.from_string v_str 0: 'b)

type position = { off: int;
                  len: int }

type db = { data_fn: filename;
            index_fn: filename;
            data: Unix.file_descr;
            index: (string, position) Hashtbl.t }

module StrKeyToStrVal = struct

  type t = db

  let create fn =
    let data_fn = fn in
    let index_fn = fn ^ ".idx" in
    let data =
      Unix.(openfile data_fn [O_RDWR; O_CREAT; O_EXCL] 0o600) in
    let index = Ht.create 11 in
    { data_fn; index_fn; data; index }

  let sync db =
    failwith "Db.sync: no Unix.sync in the stdlib?!"

  let open_rw fn =
    failwith "not implemented yet"

  let open_ro fn =
    failwith "not implemented yet"

  let close db =
    failwith "not implemented yet"

  let destroy fn =
    failwith "not implemented yet"

  let mem db k =
    failwith "not implemented yet"

  let add db k v =
    failwith "not implemented yet"

  let replace db k v =
    failwith "not implemented yet"

  let remove db k =
    failwith "not implemented yet"

  let find db k =
    failwith "not implemented yet"

  let iter f db =
    failwith "not implemented yet"

  let fold f db init =
    failwith "not implemented yet"

end
