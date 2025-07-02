# In-silico Prediction of Phytochemicals & Agent-Based Model of *Pseudomonas aeruginosa* Colonization

This repository contains my MSc research work on identifying phytochemicals to inhibit *Pseudomonas aeruginosa* colonization in the human respiratory tract, alongside an agent-based model (ABM) developed in NetLogo to simulate bacterial dynamics and intervention strategies.

##  Project Overview

- **Goal:** Predict phytochemicals that can prevent or reduce *P. aeruginosa* binding and colonization, especially relevant for cystic fibrosis (CF) patients.
- **Approach:**  
  - Built a library of 276,518 natural compounds (from LOTUS database).  
  - Applied ADMET and drug-likeness filters (Lipinski’s rules, toxicity, bioavailability), selecting 444 candidates.
  - Performed molecular docking (AutoDock Vina) against 19 *P. aeruginosa* virulence proteins including outer membrane proteins, pili, flagella, and secretion system components.
  - Identified 4 top compounds: **Betulinic acid, Resveratrol, Rosadiene, Stigmasterol**.
- **Extension:** Developed a NetLogo ABM simulating bacterial populations, host interaction, and phytochemical treatment dynamics.

# Phytochemical Treatment ABM for *Pseudomonas aeruginosa*

##  Overview
This NetLogo agent-based model simulates the effect of phytochemical treatments for decolonization of *Pseudomonas aeruginosa* in the human respiratory tract. 
The compounds selected through in-silico screening and molecular docking, exhibit strong interactions with *P. aeruginosa* virulence proteins and demonstrate drug-like properties.

The model illustrates the dynamics of bacterial colonization and evaluates the potential of phytochemicals to reduce bacterial populations, accounting for varying levels of bacterial resistance.

---

##  Requirements
- NetLogo version: **6.2.0** (or later)

---

##  How to Run
1️- Download or clone the repository:
```bash
 git clone https://github.com/afra-muhammad/ABM-Model
```
2- Open the model

    Open ABM-Netlogo-Model.nlogo in NetLogo.

3- Use the interface controls

    Sliders

        Nbacterias: Initial number of bacteria

        Nphytochemicals: Initial number of phytochemicals

        Base Resistance: Adjusts bacterial resistance levels

    Buttons

        Setup: Initializes the environment, bacteria, and phytochemicals

        Go: Runs the simulation

        Toggle Reproduction: Enables/disables bacterial reproduction

        Dose: Adds more phytochemicals during the simulation

4- Observe the plot

    The plot tracks population over time:

        Green: Phytochemicals

        Gray: Low-resistance bacteria

        Sky-blue: Medium-resistance bacteria

        Yellow: High-resistance bacteria

        Red: Superbug bacteria

## Experiments to Try

Equal Bacteria & Phytochemicals with Reproduction ON

    Set Nbacterias ≈ Nphytochemicals

    Turn reproduction on

    Test different resistance levels

Equal Bacteria & Phytochemicals with Reproduction OFF

    Same as above but reproduction off

Double Phytochemicals, Half Bacteria

    Use DOSE to double phytochemicals

    Reproduction off

More Bacteria, Fewer Phytochemicals

    Double bacteria, halve phytochemicals

    Test with reproduction on/off

## Key Observations

    Low resistance → phytochemicals are highly effective

    High resistance → bacteria survive longer; reproduction exacerbates survival

    Higher phytochemical doses help overcome resistance to some extent

## Model Extensions

Consider adding:

    Environmental factors (e.g. pH effects on efficacy)

    Bacterial traits (e.g. flagella count affecting movement/energy)

## License

This project is licensed under the MIT License. See LICENSE for details.

## Citation

If you use this model, please cite:
Afra Muhammad (2025). Phytochemical Treatment ABM for Pseudomonas aeruginosa [NetLogo]. Available at: https://github.com/afra-muhammad/ABM-Model



