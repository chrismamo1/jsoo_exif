(*module File : sig
  type t

  val to_jsoo_file : t -> Js_of_ocaml.File.any
    [@@js.custom
      let to_jsoo_file (x: t): Js_of_ocaml.File.file_any = (x: Js_of_ocaml.File.file_any)
    ]
end*)

module Img : sig
  type t

  (** [img_of_string s callback] takes the textual data URI specified by [s] and
    * produces an image.
    *)
  val of_data_uri : string -> (t -> unit) -> unit
    [@@js.global "imgOfString"]
  
  (** [to_data_uri img callback] turns and image into a data URI. *)
  val to_data_uri : t -> (string -> unit) -> unit
    [@@js.global "stringOfImg"]
  
  (** [to_file img callback] creates a [File] object representing the image. *)
  val to_file : t -> (Ojs.t -> unit) -> unit
    [@@js.global "fileOfImg"]
end

(** [get_data callback img tag] gets the EXIF tag [tag] from [img], passing it to
  * [callback].
  *)
val get_data : Img.t -> string -> (string -> unit) -> unit
  [@@js.global "getData"]

(** [get_orientation callback img] is the same as [get_data callback img "Orientation"]
  *)
val get_orientation : Img.t -> (string -> unit) -> unit
  [@@js.global "getOrientation"]

(** [reorient_image callback data_url] 
  *)
val reorient_image : Img.t -> (Img.t -> unit) -> unit
  [@@js.global "reorientImage"]
