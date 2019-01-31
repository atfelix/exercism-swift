struct MinuteCalculator {
    let hourLength: Minutes
    let dayLength: Hours

    func positiveHours(hours: Hours, minutes: Minutes) -> Hours {
        return totalMinutes(hours: hours, minutes: minutes) / hourLength % dayLength
    }

    func positiveMinutes(hours: Hours, minutes: Minutes) -> Minutes {
        return totalMinutes(hours: hours, minutes: minutes) % hourLength
    }

    private func totalMinutes(hours: Hours, minutes: Minutes) -> Minutes {
        let totalMinutes = hours * hourLength + minutes
        let totalMinutesInADay = hourLength * dayLength
        let positiveMinutesInADay = totalMinutes >= 0 ? totalMinutes : (totalMinutes % totalMinutesInADay + totalMinutesInADay)

        return positiveMinutesInADay
    }
}

