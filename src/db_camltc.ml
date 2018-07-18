
type filename = string

module RO = struct

  module RO = Dokeysto.Db.RO

  type t = RO.t

  let open_existing fn =
    RO.open_existing fn

  let dummy () =
    RO.dummy ()

  let close db =
    RO.close db

  let mem db k =
    RO.mem db k

  let find db k =
    RO.find db k

  let iter f db =
    RO.iter (fun k z ->
        f k z
      ) db

  let fold f db init =
    RO.fold (fun k z acc ->
        f k z acc
      ) db init

end

module RW = struct

  module RW = Dokeysto.Db.RW

  type t = RW.t

  let create fn =
    RW.create fn

  let open_existing fn =
    RW.open_existing fn

  let dummy () =
    RW.dummy ()

  let close db =
    RW.close db

  let sync db =
    RW.sync db

  let destroy db =
    RW.destroy db

  let mem db k =
    RW.mem db k

  let add db k str =
    RW.add db k str

  let replace db k str =
    RW.replace db k str

  let remove db k =
    RW.remove db k

  let find db k =
    RW.find db k

  let iter f db =
    RW.iter (fun k z ->
        f k z
      ) db

  let fold f db init =
    RW.fold (fun k z acc ->
        f k z acc
      ) db init

end
