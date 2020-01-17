
type filename = Common.filename

module type Key_val = sig
  val string_of_key: 'a -> string
  val key_of_string: string -> 'a

  val string_of_value: 'b -> string
  val value_of_string: string -> 'b
end

(** {4 Read-only persistent generic key to generic value hash table} *)

module RO: functor (KV: Key_val) -> sig

  type t

  (** [open_existing fn] open in read-only mode the persistent
      hashtbl whose data are stored in file [fn] and whose
      index is stored in [fn ^ ".idx"]. *)
  val open_existing: filename -> t

  (** [dummy ()] create a value of type [t].
      Do not do anything with this value. *)
  val dummy: unit -> t

  (** [close db] close the previously opened [db]. *)
  val close: t -> unit

  (** [mem db k] check if [k] is bound in [db]. *)
  val mem: t -> 'a -> bool

  (** [find db k] get the current binding of [k] in [db]
      or raise [Not_found]. *)
  val find: t -> 'a -> 'b

  (** [iter f db] apply [f] to all key-value pairs in [db].
      Cf. Hashtbl.iter for details. *)
  val iter: ('a -> 'b -> unit) -> t -> unit

  (** [fold f db init] fold [f] over all key-value pairs in [db].
      Cf. Hashtbl.fold for details. *)
  val fold: ('a -> 'b -> 'c -> 'c) -> t -> 'c -> 'c

end

(** {4 Read-write persistent generic key to generic value hash table} *)

module RW: functor (KV: Key_val) -> sig

  type t

  (** [create fn] create in read-write mode the persistent
      hashtbl whose data are stored in file [fn] and whose
      index is stored in [fn ^ ".idx"]. *)
  val create: filename -> t

  (** [open_existing fn] open in read-write mode the persistent
      hashtbl whose data are stored in file [fn] and whose
      index is stored in [fn ^ ".idx"]. *)
  val open_existing: filename -> t

  (** [dummy ()] create a value of type [t].
      Do not do anything with this value. *)
  val dummy: unit -> t

  (** [close db] close the previously opened [db]. *)
  val close: t -> unit

  (** [sync db] sync to disk the data and metadata (index) of [db]. *)
  val sync: t -> unit

  (** [destroy db] rm data and metadata files of [db] and clear [db]'s
      index hashtbl. *)
  val destroy: t -> unit

  (** [mem db k] check if [k] is bound in [db]. *)
  val mem: t -> 'a -> bool

  (** [add db k v] add the key-value binding [(k,v)] to [db]. *)
  val add: t -> 'a -> 'b -> unit

  (** [replace db k v] replace the current binding for [k] in [db]
      by a binding from [k] to [v].
      Cf. Hashtbl.replace for details. *)
  val replace: t -> 'a -> 'b -> unit

  (** [remove tbl k] remove the current binding for [k] in [db].
      Cf. Hashtbl.replace for details. *)
  val remove: t -> 'a -> unit

  (** [find db k] get the current binding of [k] in [db]
      or raise [Not_found]. *)
  val find: t -> 'a -> 'b

  (** [iter f db] apply [f] to all key-value pairs in [db].
      Cf. Hashtbl.iter for details. *)
  val iter: ('a -> 'b -> unit) -> t -> unit

  (** [fold f db init] fold [f] over all key-value pairs in [db].
      Cf. Hashtbl.fold for details. *)
  val fold: ('a -> 'b -> 'c -> 'c) -> t -> 'c -> 'c

end
