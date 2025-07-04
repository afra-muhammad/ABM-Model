breed [bacterias bacteria]
breed [phytochemicals phytochemical]

turtles-own [
  energy ; Energy for movement, reproduction, and survival
  resistance-level  ; Resistance of bacteria to phytochemicals (0-1)
]

phytochemicals-own [
  efficacy ; Represents how effective the phytochemical is (0-1)
]

to setup
  clear-all
  ; Set the background color to represent the human respiratory tract
  ask patches [ set pcolor pink ]

  ; Set the default shape for bacterias and phytochemicals
  set-default-shape bacterias "bacteria"
  set-default-shape phytochemicals "circle"

  ; Create bacteria and phytochemical agents
  create-agents

  ; Allow reproduction
  set reproduce? true
  reset-ticks
end

to create-agents
  ; Create bacterias with specified properties
  create-bacterias Nbacterias [
    set color red
    set size 1.5
    setxy random-xcor random-ycor
    set energy 50 + random 50 ; Initial energy between 50 and 100
    set resistance-level base-resistance + random-float 0.2 ; Resistance based on user input
    if resistance-level > 1 [ set resistance-level 1 ] ; Cap resistance at 1
  ]

  ; Create phytochemicals with random efficacy
  create-phytochemicals Nphytochemicals [
    set color green
    set size 0.7
    setxy random-xcor random-ycor
    set efficacy random-float 1 ; Random efficacy between 0 and 1
  ]
end

to go
  ask bacterias [
    move-turtle
    ; Set color based on resistance level
    if resistance-level < 0.1 [ set color gray ]       ; Low resistance
    if resistance-level < 0.25 and resistance-level >= 0.1 [ set color sky ] ; Medium resistance
    if resistance-level < 0.5 and resistance-level >= 0.25 [ set color yellow ] ; High resistance
    if resistance-level >= 0.5 [ set color red ]       ; Superbug (very high resistance)
  ]

    ask phytochemicals [
    rt random 360
    fd 1
  ]

  ; Bacteria interact with phytochemicals
  interact-with-phytochemicals

  ; Bacteria reproduce based on energy
  if reproduce? [
    reproduce-bacteria
  ]

  ; Check if bacteria die from low energy
  check-death

  ; End simulation if conditions are met
  if ticks > 300 or (count bacterias = 0) [ stop ]
  tick
end

; Bacteria move and expend energy
to move-turtle
  rt random 360
  fd 1
  set energy energy - 1 ; Movement costs 1 energy
end

; Bacteria interact with phytochemicals
to interact-with-phytochemicals
  ask bacterias [
    let nearby-phytochemical one-of phytochemicals in-radius 1
    if nearby-phytochemical != nobody [
      ; Compare resistance vs efficacy
      if [efficacy] of nearby-phytochemical > resistance-level [
        die ; Bacteria dies if efficacy surpasses resistance
      ]
    ]
  ]
end

; Bacteria reproduce based on their energy
to reproduce-bacteria
  ask bacterias [
    if energy > 50 [ ; Reproduce if energy is greater than 50
      set energy energy - 50 ; Reproduction costs 50 energy
      hatch 1 [
        set size 1.5
        rt random 360
        fd 1
        set energy 50 ; New offspring gets 50 energy
        set resistance-level resistance-level + random-float 0.2
        if resistance-level > 1 [ set resistance-level 1 ] ; Cap resistance
        if resistance-level < 0 [ set resistance-level 0 ] ; Prevent negative resistance
      ]
    ]
  ]
end

; Check if bacteria die from low energy
to check-death
  ask bacterias [
    if energy <= 0 [ die ]
  ]
end

; Add new phytochemicals when the "Dose" button is pressed
to dose
  create-phytochemicals Nphytochemicals [
    set color green
    set size 0.7
    setxy random-xcor random-ycor
    set efficacy random-float 1 ; Assign random efficacy to new phytochemicals
  ]
end

; Toggle reproduction using a button
to toggle-reproduction
  set reproduce? not reproduce?
end
@#$#@#$#@
GRAPHICS-WINDOW
254
21
691
459
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
9
33
72
66
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
93
32
156
65
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
0

SLIDER
0
134
172
167
Nbacterias
Nbacterias
10
1000
1000.0
1
1
NIL
HORIZONTAL

SLIDER
0
185
172
218
Nphytochemicals
Nphytochemicals
10
1000
1000.0
1
1
NIL
HORIZONTAL

MONITOR
836
142
938
187
NIL
Count bacterias
17
1
11

MONITOR
702
142
823
187
NIL
Count phytochemicals
17
1
11

PLOT
702
199
1103
457
Bacteria vs Phytochemicals population
Time
Total Populations
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Low resistance" 1.0 0 -7500403 true "plot count bacterias with [resistance-level <= 0.05]" "plot count bacterias with [resistance-level < 0.1]"
"Medium resistance" 1.0 0 -13791810 true "plot count bacterias with [resistance-level > 0.05 and resistance-level <= 0.5]" "plot count bacterias with [resistance-level >= 0.1 and resistance-level < 0.25]\n"
"High resistance" 1.0 0 -1184463 true "plot count bacterias with [resistance-level > 0.5]" "plot count bacterias with [resistance-level >= 0.25 and resistance-level < 0.5]"
"Superbug" 1.0 0 -2674135 true "" "plot count bacterias with [ resistance-level >= 0.5]"
"Phytochemicals" 1.0 0 -10899396 true "" "plot count phytochemicals"

SWITCH
16
83
128
116
reproduce?
reproduce?
0
1
-1000

BUTTON
702
102
765
135
NIL
Dose
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
0
238
172
271
base-resistance
base-resistance
0
1
0.8
0.10
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

The purpose of this model is to simulate the effect of phytochemical treatments for decolonization of _**Pseudomonas aeruginosa**_ in the human respiratory tract.

This model is based on my MS research work,where i have identified four promising phytochemicals, **Betulinic acid**, **Rosadiene**, **Resveratrol**, and **Stigmasterol**, as potential candidates for addressing the challenges posed by _P. aeruginosa_ as a highly resistant pathogen. Through _In-silico_ screening and molecular docking, these compounds exhibited strong interactions with _P. aeruginosa_ virulence proteins including cell membrane proteins and demonstrated drug-like properties. 


## HOW IT WORKS

#### Agents:

The model consists of two types of agents: bacteria (_Pseudomonas aeruginosa_) and phytochemicals.

#### Environment:

The agents interact within a simulated environment representing the human respiratory tract.

### Rules: 

#### Movement:

Bacteria move randomly across the environment.

#### Interaction:

When bacteria encounter phytochemicals, their survival depends on their resistance level compared to the efficacy of the phytochemical.

### Outcome: 

Phytochemicals inhibit or eliminate bacteria if their efficacy surpasses the bacteria’s resistance depending on the resistance level and dosing.

### Goal:

Over time, the model demonstrates how effective phytochemical treatments are in reducing bacterial colonization and highlighting the challenges posed by bacterial resistance.

## HOW TO USE IT

### User Controls

#### Sliders:

*  Nbacterias: Number of bacteria to initialize.
*  Nphytochemicals: Number of phytochemicals to initialize.
*  Base Resistance: Adjusts the overall resistance levels of bacteria.

#### Buttons:

*  Setup: Initializes the environment, bacteria, and phytochemicals.
*  Go: Runs the simulation.
*  Toggle Reproduction: Turns bacterial reproduction on or off.
*  Dose: Adds new phytochemicals to the environment.

#### Plot:

The model includes a plot titled "Bacterial vs Phytochemicals Population". The x-axis represents time, and the y-axis represents the total population. The plot tracks:

*  Phytochemicals (Green Line): Total number of phytochemicals.
*  Low-Resistance Bacteria (Gray Line)
*  Medium-Resistance Bacteria (Sky-blue Line)
*  High-Resistance Bacteria (Yellow Line)
*  Superbug Bacteria (Red Line)

### To run model:

*  The model initializes with reproduction ON by default. Users can turn it OFF.

*  Bacteria reproduce based on their energy levels. They require energy for movement, reproduction, and survival.

*  Bacteria possess a resistance level, which is transmitted to their offspring. The offspring's resistance may increase or decrease within a defined range. Users can adjust the resistance levels using the base-resistance slider.

*  Phytochemicals have efficacy that determines their ability to kill bacteria.

*  In each tick, all bacteria and phytochemicals move a small distance in a random direction. 

## THINGS TO NOTICE

*  When bacterial resistance is low, phytochemicals effectively kill bacteria, causing the bacterial population to decrease rapidly.

*  At higher resistance levels, phytochemicals become less effective, allowing bacteria to survive longer and making them harder to eliminate.

*  If reproduction is enabled and resistance is high, the bacterial population can difficult to kill.

*  Dosing the environment with new phytochemicals helps control bacterial populations, but its effectiveness depends on the resistance levels of the bacteria.

*  When an equal percentage of Nbacterias and Nphytochemicals is used, phytochemicals can kill bacteria more effectively compared to when the number of phytochemicals is half that of the bacteria.

## THINGS TO TRY

### Equal Numbers of Bacteria and Phytochemicals with Reproduction On

#### Setup:
*  Turn REPRODUCE? to "on."
*  Use equal numbers of bacteria (Nbacteria) and phytochemicals (Nphytochemicals).

#### Experiment:
*  Start with low resistance levels for bacteria and observe how quickly they are killed.
*  Gradually increase the resistance level and note how the time required to kill bacteria increases.
*  At high resistance levels, bacteria survive longer and grow, but phytochemicals able to kill them.

### Equal Numbers of Bacteria and Phytochemicals with Reproduction Off

#### Setup:
*  Turn REPRODUCE? to "off."
*  Use equal numbers of bacteria (Nbacteria) and phytochemicals (Nphytochemicals).

#### Experiment:
*  Repeat the scenario above, testing the model at low to high resistance levels for bacteria.
*  Compare the results to the case when reproduction is on.
*  Note how resistance affects the time needed for eradication when reproduction is not a factor.

### Half the Number of Bacteria and Double the Phytochemicals

#### Setup:
*  Use half the number of bacteria (N bacteria ÷ 2) and double the number of phytochemicals (2 × Nphytochemicals)(double the number of phytochemicals by pressing the DOSE button).
*  Turn REPRODUCE? to "off" for this experiment.


#### Experiment:
*  Test this scenario at different resistance levels:
*  Low resistance: Observe how quickly bacteria are killed.
*  High resistance: Bacteria survive longer but are eventually eradicated by the increased phytochemical dose.

### More Bacteria and Fewer Phytochemicals

#### Setup:
*  Use more bacteria (Nbacteria × 2) and fewer phytochemicals (Nphytochemicals ÷ 2).
*  Start with REPRODUCE? set to "on" or "off" depending on the scenario you wish to test.

#### Experiment:
*  At low resistance levels, observe how long it takes for fewer phytochemicals to eliminate the bacteria.
*  At high resistance levels, bacteria survive for longer, especially when reproduction is on.
*  Note how reproduction and resistance levels influence the time required to kill bacteria under these conditions.
 

## EXTENDING THE MODEL

*  To extend this model, consider incorporating additional environmental factors that could influence bacterial survival and reproduction. For instance, study the effect of pH levels on the efficacy of phytochemicals and bacterial resistance.

*  Enhance the model by introducing other bacterial traits, such as the number of flagella, which could influence movement speed and energy use. 

## NETLOGO FEATURES

### Dynamic Visualization:

Custom coloring of bacteria based on resistance levels (gray for low resistance, sky blue for medium resistance, yellow for high resistance, and red for superbugs) is implemented. These visualizations help track changes in resistance visually and in real-time during simulation.

### Plots and Graphing: 

The model integrates real-time plotting to track bacterial population dynamics against phytochemicals. The plot adjusts dynamically to reflect changes in resistance levels and the effects of reproduction and dosing.

## RELATED MODELS

Virus model in Netlogo library.


## CREDITS AND REFERENCES

*  Wilensky, U. (1998). NetLogo Virus model. http://ccl.northwestern.edu/netlogo/models/Virus. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.
*  Xiang, L. (2021). Evolution of antibiotic resistance. Department of STEM Education, University of Kentucky , Lexington, KY.
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

bacteria
true
0
Polygon -7500403 false true 60 60 60 210 75 270 105 300 150 300 195 300 225 270 240 225 240 60 225 30 180 0 150 0 120 0 90 15
Polygon -7500403 false true 75 60 75 225 90 270 105 285 150 285 195 285 210 270 225 225 225 60 210 30 180 15 150 15 120 15 90 30
Rectangle -7500403 true true 75 135 90 180
Rectangle -7500403 false true 210 135 225 180
Rectangle -7500403 true true 210 135 225 180

bacteria 1
true
0
Rectangle -2674135 false false 180 90 195 120
Rectangle -2674135 false false 180 120 195 150
Rectangle -7500403 false true 165 105 180 105
Rectangle -7500403 false true 150 105 180 105
Rectangle -2674135 false false 150 105 180 120
Rectangle -7500403 false true 165 135 180 135
Rectangle -7500403 false true 195 120 225 120
Rectangle -2674135 false false 195 105 210 135

bacteria-holes-1
true
0
Line -7500403 true 240 75 225 45
Line -7500403 true 240 75 240 120
Line -7500403 true 240 180 240 225
Line -7500403 true 225 255 195 285
Line -7500403 true 225 45 195 15
Line -7500403 true 75 45 105 15
Line -7500403 true 60 75 75 45
Line -7500403 true 60 75 60 180
Line -7500403 true 60 180 60 225
Line -7500403 true 60 225 75 255
Line -7500403 true 105 15 195 15
Line -7500403 true 240 225 225 255
Line -7500403 true 75 255 105 285
Line -7500403 true 105 285 195 285

bacteria-holes-2
true
0
Line -7500403 true 240 75 225 45
Line -7500403 true 240 75 240 120
Line -7500403 true 240 180 240 225
Line -7500403 true 225 255 195 285
Line -7500403 true 225 45 195 15
Line -7500403 true 75 45 105 15
Line -7500403 true 60 75 75 45
Line -7500403 true 60 75 60 120
Line -7500403 true 60 180 60 225
Line -7500403 true 60 225 75 255
Line -7500403 true 105 15 195 15
Line -7500403 true 240 225 225 255
Line -7500403 true 75 255 105 285
Line -7500403 true 105 285 195 285

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
