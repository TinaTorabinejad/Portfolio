import React from 'react'

export default function Employee() {
    return ( // Needs form submission
        <>
            <h1>Employee Parking Access Keycards</h1>
            <body>
                <section id="parking-lot">
                    <form>
                        <h2>Department Number and Name</h2>
                        <label for="parking">Select Department </label>
                        <input list="list" id="parking" name="parking" required/>
                        <datalist id="list">
                            <option value="City Hall No.1"></option>
                            <option value="City Hall No.2"></option>
                        </datalist>
                        <hr/>

                        <label for="parking lot">Parking Lot Area </label>
                        <input list="parkingLot" id="parking lot" name="parking" required/>
                        <datalist id="parkingLot">
                            <option value="Lot A"></option>
                            <option value="Lot B"></option>
                            <option value="Lot C"></option>
                        </datalist>
                        <br/>
                        <hr/>

                        <section class="Time Period">
                            <label for="start">Select Start Period to Park: </label>
                            <input type="date" id="start" name="start" min="2022-07-01" max="2022-12-31" required/>
                            <br/>
                            <br/>
                            <label for="end">Select End Period to Park: </label>
                            <input type="date" id="end" name="end" max="2022-12-31" required/>
                        </section>
                        <br/>
                        <button type="submit">Submit</button>
                    </form>
                </section>
            </body>
        </>
    )
}