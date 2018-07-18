
module Bdb = Camltc.Bdb

type filename = string

type db = { fn: filename;
            bdb: Bdb.bdb }

module RW = struct

  type t = db

  let create fn =
    let mode = Bdb.(oreader lor owriter lor ocreat lor otrunc lor onolck) in
    let bdb = Bdb.create ~mode fn [] in
    { fn; bdb }

  let open_existing fn =
    let mode = Bdb.(oreader lor owriter lor onolck) in
    let bdb = Bdb.create ~mode fn [] in
    { fn; bdb }

  let dummy () =
    let dummy_fn = Filename.temp_file "" "" in
    create dummy_fn

  let close db =
    Bdb.close db.bdb

  let sync db =
    Bdb.sync db.bdb

  let destroy db =
    Bdb.close db.bdb;
    Bdb.delete db.bdb;
    Sys.remove db.fn

  let mem db k =
    Bdb.exists db.bdb k

  let add db k str =
    Bdb.put db.bdb k str

  let replace db k str =
    Bdb.out db.bdb k;
    Bdb.put db.bdb k str

  let remove db k =
    Bdb.out db.bdb k

  let find db k =
    Bdb.get db.bdb k

  let iter f db =
    if Bdb.get_key_count db.bdb > Int64.one then
      try
        let cur = Bdb.get_cursor db.bdb in
        Bdb.first db.bdb cur;
        while true do
          let k = Bdb.key db.bdb cur in
          let v = Bdb.value db.bdb cur in
          f k v;
          Bdb.next db.bdb cur
        done
      with Not_found -> () (* end of db *)

  let fold (f: string -> string -> 'a -> 'a) db init =
    let acc = ref init in
    iter (fun k v ->
        acc := f k v !acc
      ) db;
    !acc

end

module RO = struct

  type t = db

  let open_existing fn =
    failwith "not implemented yet"
    (* RO.open_existing fn *)

  let dummy () =
    failwith "not implemented yet"
    (* RO.dummy () *)

  let close db =
    failwith "not implemented yet"
    (* RO.close db *)

  let mem db k =
    failwith "not implemented yet"
    (* RO.mem db k *)

  let find db k =
    failwith "not implemented yet"
    (* RO.find db k *)

  let iter f db =
    failwith "not implemented yet"
    (* RO.iter (fun k z ->
     *     f k z
     *   ) db *)

  let fold f db init =
    failwith "not implemented yet"
    (* RO.fold (fun k z acc ->
     *     f k z acc
     *   ) db init *)

end
