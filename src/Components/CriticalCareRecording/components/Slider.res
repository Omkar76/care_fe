// USAGE:

// let (slide, setSlider) = React.useState(() => "0")


// <Slider
// title="Diastolic"
// start="0"
// end="100"
// interval="10"
// step={0.1}
// value={slide}
// setValue={(s) => setSlider(_ => s)}
// getLabel={getLabel}
// />
//
//
// And getLabel can be something like:
//
// let getLabel = (value) => {
//         if (value > 50.0) {
//             ("Disease", "#ff0000")
//         } else {
//             ("Normal", "#2856ff")
//         }
//     }


let s = React.string
%%raw(`import ("./styles.css")`)


@react.component
let make = (~title: string, ~start: string, ~end: string, ~step: float, ~value: string, ~setValue: (string) => unit, ~getLabel: (float) => (string, string), ~interval: string) => {
  let (textColor, setColor) = React.useState(() => "#2856ff")
  let (text, setText) = React.useState(() => "Normal")
  let e = end->Belt.Int.fromString->Belt.Option.getWithDefault(0)
  let i = interval->Belt.Int.fromString->Belt.Option.getWithDefault(0)

  let iterations = (Belt.Int.toFloat(i) /. Belt.Int.toFloat(e)) *. 100.0


  React.useEffect1(() => {
    let (text, color) = getLabel(value->Belt.Float.fromString->Belt.Option.getWithDefault(0.0))
    setColor(_ => color)
    setText(_ => text)

    None
  }, [value])

  <>
      <section className="slider-box">
        <div className="slider-head">
          <h1>
            {title->s}
          </h1>
          <label htmlFor="measure" style={ReactDOM.Style.make(~color=textColor, ())}>
            {text->s}
            <input name="measure" type_="number" step={step} max={end} min={start} value={value} onChange={(event) => setValue(ReactEvent.Form.target(event)["value"])} />
          </label>
        </div>
        <div className="slider-container">
          <input type_="range" step={step} max={end} min={start} value={value} className="slider" onChange={(event) => setValue(ReactEvent.Form.target(event)["value"])} />
          <div className="indicators">
            <div className="tick" style={ReactDOM.Style.make(~backgroundSize=`${iterations->Belt.Float.toString}% 100%`, ())}></div>
          </div>
        </div>
      </section>
  </>
}
