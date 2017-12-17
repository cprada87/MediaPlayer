//
//  ReproductorTools.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation

var musicDict:[[String:Any]] = [
    ["id":0, "albumId":0, "lists":[0], "title":"50 cent Remix", "file":"50 cent"],
    ["id":1, "albumId":0, "lists":[0], "title":"Still D.R.E", "file":"AxwellIngrosso - More Than You Know"],
    ["id":2, "albumId":1, "lists":[0], "title":"Rap God", "file":"B S O Gladiador -Now we are free"],
    ["id":3, "albumId":1, "lists":[0], "title":"Fade", "file":"Banda Sonora - El Senor de los Anillos"],
    ["id":4, "albumId":2, "lists":[0], "title":"Stronger", "file":"Bebo Valdes & Diego El Cigala.- Lagrimas Negras"],
    ["id":5, "albumId":2, "lists":[0], "title":"Gin and Juice", "file":"Beethoven - Moonlight Sonata (FULL)"],
    ["id":6, "albumId":3, "lists":[0], "title":"Smoke weed everiday", "file":"Chris Brown - Look At Me Now ft. Lil Wayne, Busta Rhymes"],
    ["id":7, "albumId":3, "lists":[0], "title":"BADBADNOTGOOD", "file":"despacito"],
    ["id":8, "albumId":15, "lists":[0], "title":"Santorini Greece", "file":"Diego El Cigala - El Raton (Official Video)"],
    ["id":9, "albumId":9, "lists":[1], "title":"More than you know", "file":"Dr. Dre - Still D.R.E. ft. Snoop Dogg"],
    ["id":10, "albumId":8, "lists":[1], "title":"First Of the year", "file":"El Barrio - El Viejo Verano (Videoclip Oficial)"],
    ["id":11, "albumId":7, "lists":[1], "title":"Spaceman", "file":"El Barrio - Las Costuras del Alma"],
    ["id":12, "albumId":20, "lists":[1], "title":"Bangarang", "file":"El Barrio - Pa Madrid"],
    ["id":13, "albumId":20, "lists":[1], "title":"Scary monsters", "file":"El Barrio - Querida Enemiga (Videoclip Oficial)"],
    ["id":14, "albumId":20, "lists":[1], "title":"Make It Bun Dem", "file":"Eminem - Rap God (Explicit)"],
    ["id":15, "albumId":20, "lists":[1], "title":"Mind", "file":"EPIC Game of Thrones Theme (Cover) + Fan Trailer"],
    ["id":16, "albumId":20, "lists":[1], "title":"Purple lanborguhini", "file":"First Of The Year (Equinox) - Skrillex OFFICIAL"],
    ["id":17, "albumId":12, "lists":[2], "title":"Sweet child O' Mine", "file":"Guns N' Roses - Sweet Child O' Mine"],
    ["id":18, "albumId":12, "lists":[2], "title":"Welcome to the Jungle", "file":"Guns N' Roses - Welcome To The Jungle"],
    ["id":19, "albumId":16, "lists":[2], "title":"Californication", "file":"Hardwell - Spaceman (Original Mix)"],
    ["id":20, "albumId":17, "lists":[2], "title":"Can't Stop", "file":"Jose Merce - Del amanecer"],
    ["id":21, "albumId":18, "lists":[2], "title":"Otherside", "file":"Jose MerceAire"],
    ["id":22, "albumId":16, "lists":[2], "title":"Under The Bridge ", "file":"Kanye West - Fade (Explicit)"],
    ["id":23, "albumId":20, "lists":[1], "title":"Where Are Ü Now", "file":"Kanye West - Stronger"],
    ["id":24, "albumId":20, "lists":[0 ,1], "title":"El chapo", "file":"Mozart - Requiem"],
    ["id":25, "albumId":12, "lists":[3], "title":"BSO Gladiator", "file":"Ragga Bomb (Skrillex & Zomboy Remix)"],
    ["id":26, "albumId":3, "lists":[3], "title":"BSO El señor de los anillos", "file":"Banda Sonora - El Senor de los Anillos"],
    ["id":27, "albumId":5, "lists":[3], "title":"Moonlight Sonata", "file":"Red Hot Chili Peppers - Californication Official Music Video"],
    ["id":28, "albumId":14, "lists":[3], "title":"BSO Juego de tronos", "file":"Red Hot Chili Peppers - Can't Stop Official Music Video"],
    ["id":29, "albumId":2, "lists":[3], "title":"Requiem", "file":"Red Hot Chili Peppers - Otherside Official Music Video"],
    ["id":30, "albumId":2, "lists":[3], "title":"BSO Star Wars", "file":"Red Hot Chili Peppers - Under The Bridge Official Music Video"],
    ["id":31, "albumId":4, "lists":[4], "title":"Lagrimas negras", "file":"Rick Ross - Santorini Greece"],
    ["id":32, "albumId":1, "lists":[4], "title":"El raton", "file":"Rosario Flores con el Cigala - Te quiero, te quiero"],
    ["id":33, "albumId":10, "lists":[4], "title":"El viaje de verano", "file":"SKRILLEX - Bangarang feat. Sirah Official Music Video"],
    ["id":34, "albumId":11, "lists":[4], "title":"Las costuras", "file":"SKRILLEX - Scary Monsters And Nice Sprites"],
    ["id":35, "albumId":10, "lists":[4], "title":"Pa Madrid", "file":"Skrillex & Damian Jr. Gong Marley - Make It Bun Dem OFFICIAL VIDEO"],
    ["id":36, "albumId":11, "lists":[4], "title":"Querida enemiga", "file":"Skrillex & Diplo - Mind feat. Kai (Official Video)"],
    ["id":37, "albumId":10, "lists":[4], "title":"Purple Lamborghini Official Video", "file":"Star Wars- The Imperial March (Darth Vader's Theme)"],
    ["id":38, "albumId":11, "lists":[4], "title":"Aire", "file":"SNOOP DOGG - BADBADNOTGOOD - Lavender (Nightfall Remix)"],
    ["id":39, "albumId":4, "lists":[0], "title":"Look At Me Now ft. Lil Wayne", "file":"Snoop Dogg - Gin And Juice"],
    ["id":40, "albumId":20, "lists":[1], "title":"Ragga Bomb", "file":"Star Wars- The Imperial March (Darth Vader's Theme)"],
    ["id":41, "albumId":1, "lists":[4], "title":"Te quiero, te ", "file":"The Game & Skrillex - El Chapo"]
    
]

func getAlbums(artistId: Int) -> [[String:Any]] {
    var albums = [[String:Any]]()
    for album in albumDict {
        if album["artistId"] as! Int == artistId {
            albums.append(album)
        }
    }
    return albums
}

func getArtist(artistId: Int) -> [String:Any] {
    for item in artistDict {
        if item["id"] as! Int == artistId {
            return item
        }
    }
    return [:]
}

func getAlbum(albumId: Int) -> [String:Any] {
    for item in albumDict {
        if item["id"] as! Int == albumId {
            return item
        }
    }
    return [:]
}

//var musicList:[[String:Any]] = [["title":"El nombre de la musica",
//     "file":"El nombre del asset",
//     "album":albumList[index](Enviadme un diccionario tipo String:String si no teneis que hacer en el value otro diccionario, que contenga todos los datos del album),
//     "artist":artistList[index](idem que albumList pero con todos los datos del artista, incluido los conciertos),
//     "fav":"True o false segun con lo que venga del usuario"]]
/*
var name = musicList[index]["title"] as String
var album:[String:String] = musicList["album"] as Dictionary<String,String>
var artist:[String:Any] = musicList[index]["artist"] as [String, Any]
var fav:Bool = musicList["fav"]
var musicList:[[String:Any]] = [
    ["name":"Track01",
     "file":"track01",
     "album":"Album01",
     "artist":
            ["name":"Artist01", "albums":[["name":"Album01","cover":"favorite"], ["name":"album02","cover":"noFavorite"]],
             "description":"Esto es La descripcion 1",
             "longitude":"36.718459",
             "latitude":"-4.422153"
            ],
     "cover":"favorite",
     "fav":"true"
    ],
    ["name":"Track02",
     "file":"track02",
     "album":"Album01",
     "artist":
        ["name":"Artist01", "albums":[["name":"Album03", "cover":"play"], ["name":"album04","cover":"stop"]],
         "description":"Esto es La descripcion 2",
         "longitude":40.405666,
         "latitude":-3.706885
        ],
     "cover":"noFavorite",
     "fav":false
    ],
    ["name":"Track01",
     "file":"track03",
     "album":"album02",
     "artist":
        ["name":"Artist01", "albums":[["name":"Album05", "cover":"backward"], ["name":"album06","cover":"forward"]],
         "description":"Esto es La descripcion 3",
         "longitude":132.3334,
         "latitude":44.444
        ],
     "cover":"play",
        "fav":true
    ]
]*/
