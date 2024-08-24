breed [rooms room]
breed [persons person]
breed [blinds blind]
breed [windows window]

rooms-own [
  room_size
  room-index
  solar-gain
  adjusted-solar-gain
]

persons-own [
  room-index
  clo
  met
]

windows-own [
  room-index
  window-state
]

blinds-own [
  room-index
  blind-state
  prev-blind-state
]

globals [
  occupancy-schedule ;; Assuming this global variable is already defined and initialized
  occupancy-schedule-data
  temperature-data
  outdoor-temperature
  create-occupancy
  current-tick
  max-ticks
  clo-diffs
  met-diffs
  occupancy-capacity  ;; Ensure this is a global variable
  current-room-index
  room-persons-counts ;; New variable to store the number of people in each room
  solar-GFOAO-gain-data
  solar-GFIO2-gain-data
  solar-GFIO1-gain-data
  solar-FFIO1-gain-data
  solar-FFIO2-gain-data
  solar-angle-data
  solar-angle
]

to setup
  clear-all
  set current-tick 0
  set clo-diffs []
  set met-diffs []
  set max-ticks 720 ;; You can set this according to your needs
  setup-rooms
  setup-windows
  setup-blinds
  load-data-csv
  reset-ticks
end

to setup-rooms
  ;; Ground floor individual office 1
  create-rooms 1 [
    set shape "square"
    set color grey
    set size 15
    setxy -12 14
    set room_size 13.5
    set room-index 1
    set solar-angle 0
    set solar-gain 0
  ]
  ;; Ground floor individual office 2
  create-rooms 1 [
    set shape "square"
    set color grey
    set size 15
    setxy 12 14
    set room_size 13.5
    set room-index 2
    set solar-angle 0
    set solar-gain 0
  ]
    ;; Ground floor open-area office
  create-rooms 1 [
    set shape "square"
    set color grey
    set size 15
    setxy -12 0
    set room_size 28.8
    set room-index 5
    set solar-angle 0
    set solar-gain 0
  ]
  ;; First floor individual office 1
  create-rooms 1 [
    set shape "square"
    set color grey
    set size 15
    setxy -12 -14
    set room_size 20
    set room-index 3
    set solar-angle 0
    set solar-gain 0
  ]
  ;; First floor individual office 2
  create-rooms 1 [
    set shape "square"
    set color grey
    set size 15
    setxy 12 0
    set room_size 24
    set room-index 4
    set solar-angle 0
    set solar-gain 0
  ]
end

to setup-windows
  ;; Ground floor individual office 1
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -15 19
    set room-index 1
    set window-state 0
  ]
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -10 19
    set room-index 1
    set window-state 0
  ]
  ;; Ground floor individual office 2
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy 15 19
    set room-index 2
    set window-state 0
  ]
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy 10 19
    set room-index 2
    set window-state 0
  ]
    ;; Ground floor open-area office
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -15 5
    set room-index 5
    set window-state 0
  ]
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -10 5
    set room-index 5
    set window-state 0
  ]
    create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -7 2
    set room-index 5
    set window-state 0
  ]
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -7 -2
    set room-index 5
    set window-state 0
  ]
    ;; First floor individual office 1
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -15 -9
    set room-index 3
    set window-state 0
  ]
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy -10 -9
    set room-index 3
    set window-state 0
  ]
      ;; First floor individual office 2
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy 10 5
    set room-index 4
    set window-state 0
  ]
  create-windows 1[
    set shape "square"
    set color blue
    set size 2
    setxy 15 5
    set room-index 4
    set window-state 0
  ]
end

to setup-blinds
  ;; Ground floor individual office 1
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -15 17
    set room-index 1
    set blind-state 0
  ]
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -10 17
    set room-index 1
    set blind-state 0
  ]
  ;; Ground floor individual office 2
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy 15 17
    set room-index 2
    set blind-state 0
  ]
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy 10 17
    set room-index 2
    set blind-state 0
  ]
    ;; Ground floor open-area office
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -15 3
    set room-index 5
    set blind-state 0
  ]
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -10 3
    set room-index 5
    set blind-state 0
  ]
    create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -7 0
    set room-index 5
    set blind-state 0
  ]
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -7 -4
    set room-index 5
    set blind-state 0
  ]
    ;; First floor individual office 1
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -15 -11
    set room-index 3
    set blind-state 0
  ]
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy -10 -11
    set room-index 3
    set blind-state 0
  ]
      ;; First floor individual office 2
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy 10 3
    set room-index 4
    set blind-state 0
  ]
  create-blinds 1[
    set shape "square"
    set color red
    set size 2
    setxy 15 3
    set room-index 4
    set blind-state 0
  ]
end

to load-data-csv
  file-close-all
  ; Read temperature data
  file-open "Mark Group House air temperature original Nov.csv"
  set temperature-data []
  while [not file-at-end?] [
    let line file-read-line
    ; Convert each line read into a number
    set temperature-data lput (read-from-string line) temperature-data
  ]
  file-close

  file-open "occupancy_schedule.csv"
  set occupancy-schedule-data []
  while [not file-at-end?] [
    let line file-read-line
    ; Convert each line read into a number
    set occupancy-schedule-data lput (read-from-string line) occupancy-schedule-data
  ]
  file-close

  file-open "Mark Group House solar altitude original Nov.csv"
  set solar-angle-data []
  while [not file-at-end?] [
    let line file-read-line
    ; Convert each line read into a number
    set solar-angle-data lput (read-from-string line) solar-angle-data
  ]
  file-close

  file-open "Mark Group House Ground floor open area office solar gain original Nov.csv"
  set solar-GFOAO-gain-data []
  while [not file-at-end?] [
  let line file-read-line
  set solar-GFOAO-gain-data lput (read-from-string line) solar-GFOAO-gain-data
  ]
  file-close

  file-open "Mark Group House Ground floor office 2 solar gain original Nov.csv"
  set solar-GFIO2-gain-data []
  while [not file-at-end?] [
  let line file-read-line
  set solar-GFIO2-gain-data lput (read-from-string line) solar-GFIO2-gain-data
  ]
  file-close

  file-open "Mark Group House Ground floor office 1 solar gain original Nov.csv"
  set solar-GFIO1-gain-data []
  while [not file-at-end?] [
  let line file-read-line
  set solar-GFIO1-gain-data lput (read-from-string line) solar-GFIO1-gain-data
  ]
  file-close

  file-open "Mark Group House First floor main bedroom solar gain original Nov.csv"
  set solar-FFIO1-gain-data []
  while [not file-at-end?] [
  let line file-read-line
  set solar-FFIO1-gain-data lput (read-from-string line) solar-FFIO1-gain-data
  ]
  file-close

  file-open "Mark Group House First floor 4th bedroom solar gain original Nov.csv"
  set solar-FFIO2-gain-data []
  while [not file-at-end?] [
  let line file-read-line
  set solar-FFIO2-gain-data lput (read-from-string line) solar-FFIO2-gain-data
  ]
  file-close
end

to process-solar-data
  ask rooms [
    let gain-data 0
    if room-index = 1 [
      set gain-data item current-tick solar-GFIO1-gain-data
    ]
    if room-index = 2 [
      set gain-data item current-tick solar-GFIO2-gain-data
    ]
    if room-index = 3 [
      set gain-data item current-tick solar-FFIO1-gain-data
    ]
    if room-index = 4 [
      set gain-data item current-tick solar-FFIO1-gain-data
    ]
    if room-index = 5 [
      set gain-data item current-tick solar-GFOAO-gain-data
    ]
    set solar-gain gain-data
    set adjusted-solar-gain (gain-data * 1000 / room_size)
  ]
end

to update-environment
  ifelse current-tick < length occupancy-schedule-data [
    set occupancy-schedule item current-tick occupancy-schedule-data
  ] [
    set occupancy-schedule 0 ; Or some other default value
  ]
  set outdoor-temperature item current-tick temperature-data
  set solar-angle item current-tick solar-angle-data
end

to clear-persons
  ask persons [die]
end

to go
  if current-tick >= max-ticks [
    stop  ; If max ticks reached, stop simulation
  ]

  ; Update environment status
  update-environment

  ; Calculate the number of people in each room
  let persons-count-GFIO1 round (occupancy-schedule * 2)  ; Room 1's occupancy capacity is 2
  let persons-count-GFIO2 round (occupancy-schedule * 2)  ; Room 2's occupancy capacity is 2
  let persons-count-GFOAO round (occupancy-schedule * 8)  ; Room 3's occupancy capacity is 8
  let persons-count-FFIO1 round (occupancy-schedule * 2)  ; Room 4's occupancy capacity is 2
  let persons-count-FFIO2 round (occupancy-schedule * 2)  ; Room 5's occupancy capacity is 2

  ; Clear previous persons
  clear-persons

  ; Create new persons and place them in the respective rooms
  ask rooms with [room-index = 1] [
    let room-occupancy persons-count-GFIO1
    let room-center-x -12
    let room-center-y 14
    let room-radius 3.5 ;; Room size / 2
    repeat room-occupancy [
      ask patch (room-center-x + random-float room-radius * 2 - room-radius)
               (room-center-y + random-float room-radius * 2 - room-radius) [
        sprout-persons 1 [
          set room-index 1
          set clo 0.7 + (random-float 0.3)
          set met 0.7 + (random-float 1.3)
        ]
      ]
    ]
  ]

  ask rooms with [room-index = 2] [
    let room-occupancy persons-count-GFIO2
    let room-center-x 12
    let room-center-y 14
    let room-radius 3.5 ;; Room size / 2
    repeat room-occupancy [
      ask patch (room-center-x + random-float room-radius * 2 - room-radius)
               (room-center-y + random-float room-radius * 2 - room-radius) [
        sprout-persons 1 [
          set room-index 2
          set clo 0.7 + (random-float 0.3)
          set met 0.7 + (random-float 1.3)
        ]
      ]
    ]
  ]

  ask rooms with [room-index = 5] [
    let room-occupancy persons-count-GFOAO
    let room-center-x -12
    let room-center-y 0
    let room-radius 3.5 ;; Room size / 2
    repeat room-occupancy [
      ask patch (room-center-x + random-float room-radius * 2 - room-radius)
               (room-center-y + random-float room-radius * 2 - room-radius) [
        sprout-persons 1 [
          set room-index 5
          set clo 0.7 + (random-float 0.3)
          set met 0.7 + (random-float 1.3)
        ]
      ]
    ]
  ]

  ask rooms with [room-index = 3] [
    let room-occupancy persons-count-FFIO1
    let room-center-x -12
    let room-center-y -14
    let room-radius 3.5 ;; Room size / 2
    repeat room-occupancy [
      ask patch (room-center-x + random-float room-radius * 2 - room-radius)
               (room-center-y + random-float room-radius * 2 - room-radius) [
        sprout-persons 1 [
          set room-index 3
          set clo 0.7 + (random-float 0.3)
          set met 0.7 + (random-float 1.3)
        ]
      ]
    ]
  ]

  ask rooms with [room-index = 4] [
    let room-occupancy persons-count-FFIO2
    let room-center-x 12
    let room-center-y 0
    let room-radius 3.5 ;; Room size / 2
    repeat room-occupancy [
      ask patch (room-center-x + random-float room-radius * 2 - room-radius)
               (room-center-y + random-float room-radius * 2 - room-radius) [
        sprout-persons 1 [
          set room-index 4
          set clo 0.7 + (random-float 0.3)
          set met 0.7 + (random-float 1.3)
        ]
      ]
    ]
  ]

  ; Record clo and met differences
  ask persons [
    let clo_diff clo - 0.7
    let met_diff met - 1.2
    set clo-diffs lput clo_diff clo-diffs
    set met-diffs lput met_diff met-diffs
  ]

  decide-window-opening
  decide-blind-action
  ; Update the number of people in each room
  update-room-persons-counts

  ; Update the current tick
  tick
  set current-tick current-tick + 1
end


to update-room-persons-counts
  set room-persons-counts (list (count persons with [room-index = 1])
                                (count persons with [room-index = 2])
                                (count persons with [room-index = 3])
                                (count persons with [room-index = 4])
                                (count persons with [room-index = 5]))
end

to decide-window-opening
  ask rooms [
    let room-id room-index
    let Top calculated-operative-temperature room-id
    let temperature-diff abs (Top - 22.5)  ;; Calculate the absolute difference between room operative temperature and 22.5

    ;; If the temperature difference is less than or equal to 2, skip the window state decision
    if temperature-diff <= 2 [
      stop
    ]

    ;; Continue with the window opening decision logic
    let pw calculate-pw room-id
    let num-persons count persons with [room-index = room-id]
    let turtle-randoms []
    let occupancy-discussion 0

    ifelse num-persons > 0 [
      let clo_diffs []
      let met_diffs []

      ask persons with [room-index = room-id] [
        let clo_diff clo - 0.7
        let met_diff met - 1.2
        set clo_diffs lput clo_diff clo_diffs
        set met_diffs lput met_diff met_diffs
      ]

      let i 0
      foreach clo_diffs [
        let clo_diff item i clo_diffs
        let met_diff item i met_diffs

        let total_diff abs(clo_diff + met_diff)
        let random-number 0.0
        if total_diff < 0.4 [
          set random-number (random-float 0.5 + 0.5)
        ]
        if total_diff >= 0.4 [
          set random-number random-float 0.5
        ]
        set turtle-randoms lput random-number turtle-randoms
        set i i + 1
      ]

      let sum-randoms sum turtle-randoms
      set occupancy-discussion sum-randoms / num-persons

      ifelse occupancy-discussion < pw [
        ask windows with [room-index = room-id] [
          set window-state 1  ; fully open
        ]
      ] [
        ask windows with [room-index = room-id] [
          set window-state 0  ; fully closed
        ]
      ]
    ] [
      ask windows with [room-index = room-id] [
        set window-state 0  ; fully closed
      ]
    ]
  ]
end

to decide-blind-action
  ask rooms [
    let room-id room-index
    let room-solar-angle solar-angle
    let room-solar-gain adjusted-solar-gain

    ;; Calculate the probability of blinds being raised
    let p-blinds-up-altitude exp(-3.446 + 0.019 * room-solar-angle) / (1 + exp(-3.446 + 0.019 * room-solar-angle))
    let p-blinds-up-radiation exp(-3.330 + 0.003 * room-solar-gain) / (1 + exp(-3.330 + 0.003 * room-solar-gain))
    let p-blinds-up (p-blinds-up-altitude + p-blinds-up-radiation) / 2

    ;; Calculate the probability of blinds being lowered
    let p-blinds-down-altitude exp(-3.424 + 0.018 * room-solar-angle) / (1 + exp(-3.424 + 0.018 * room-solar-angle))
    let p-blinds-down-radiation exp(-3.170 + 0.002 * room-solar-gain) / (1 + exp(-3.170 + 0.002 * room-solar-gain))
    let p-blinds-down (p-blinds-down-altitude + p-blinds-down-radiation) / 2

    ;; Calculate the number of people in the room
    let num-persons count persons with [room-index = room-id]

    ifelse num-persons > 0 [
      ;; If there are people in the room, calculate the clo and met differences for each person
      let clo_diffs []
      let met_diffs []
      let turtle-randoms []

      ask persons with [room-index = room-id] [
        let clo_diff clo - 0.7
        let met_diff met - 1.2
        set clo_diffs lput clo_diff clo_diffs
        set met_diffs lput met_diff met_diffs
      ]

      let i 0
      foreach clo_diffs [
        let clo_diff item i clo_diffs
        let met_diff item i met_diffs

        let total_diff abs(clo_diff + met_diff)
        let random-number 0.0
        if total_diff < 0.4 [
          set random-number (random-float 0.5 + 0.5)
        ]
        if total_diff >= 0.4 [
          set random-number random-float 0.5
        ]
        set turtle-randoms lput random-number turtle-randoms
        set i i + 1
      ]

      let sum-randoms sum turtle-randoms
      let occupancy-discussion sum-randoms / num-persons

      ;; Compare p-blinds-up and p-blinds-down, set the blind state
      ifelse p-blinds-up > p-blinds-down [
        ;; If p-blinds-up is higher
        ifelse occupancy-discussion < p-blinds-up [
          ask blinds with [room-index = room-id] [
            set blind-state 0
          ]
        ] [
          ask blinds with [room-index = room-id] [
            set blind-state 1
          ]
        ]
      ] [
        ;; If p-blinds-down is higher
        ifelse occupancy-discussion < p-blinds-down [
          ask blinds with [room-index = room-id] [
            set blind-state 1
          ]
        ] [
          ask blinds with [room-index = room-id] [
            set blind-state 0
          ]
        ]
      ]
    ] [
      ;; If there are no people in the room, keep the blinds' state
      ask blinds with [room-index = room-id] [
        set blind-state 0
      ]
    ]
  ]
end


to-report calculated-operative-temperature [room-id]
  let room-clo-average 0
  let room-met-average 0
  let room-persons persons with [room-index = room-id]

  ifelse any? room-persons [
    set room-clo-average mean [clo] of room-persons
    set room-met-average mean [met] of room-persons
  ] [
    set room-clo-average 0.7  ; default value
    set room-met-average 1.2  ; default value
  ]

  let room-clo-change (room-clo-average - 0.7) * 6
  let room-met-change (room-met-average - 1.2) * 6

  let calculated_operative_temperature 22.5 - room-clo-change - room-met-change  ; initial operative temperature assumed as 22 degrees

  report calculated_operative_temperature
end


to-report calculate-pw [room-id]
  let Top calculated-operative-temperature room-id
  let Tout outdoor-temperature
  let logit_pw (0.171 * Top) + (0.166 * Tout) - 6.4
  let pw 1 / (1 + exp(-1 * logit_pw))

  report pw
end

to-report room-operative-temperatures
  let temps []
  ask rooms [
    set temps lput calculated-operative-temperature room-index temps
  ]
  report temps
end
@#$#@#$#@
GRAPHICS-WINDOW
146
10
580
445
-1
-1
10.4
1
10
1
1
1
0
0
0
1
-20
20
-20
20
0
0
1
ticks
30.0

BUTTON
69
10
137
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
69
45
137
78
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
69
80
137
113
step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment0817" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="720"/>
    <metric>[window-state] of windows with [room-index = 1]</metric>
    <metric>[window-state] of windows with [room-index = 2]</metric>
    <metric>[window-state] of windows with [room-index = 3]</metric>
    <metric>[window-state] of windows with [room-index = 4]</metric>
    <metric>[window-state] of windows with [room-index = 5]</metric>
    <metric>[blind-state] of blinds with [room-index = 1]</metric>
    <metric>[blind-state] of blinds with [room-index = 2]</metric>
    <metric>[blind-state] of blinds with [room-index = 3]</metric>
    <metric>[blind-state] of blinds with [room-index = 4]</metric>
    <metric>[blind-state] of blinds with [room-index = 5]</metric>
    <metric>room-persons-counts</metric>
    <metric>room-operative-temperatures</metric>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
