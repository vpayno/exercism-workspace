"""Functions to prevent a nuclear meltdown."""


from typing import Union


def is_criticality_balanced(temperature: Union[int, float], neutrons_emitted: Union[int, float]) -> bool:
    """Verify criticality is balanced.

    :param temperature: int or float - temperature value in kelvin.
    :param neutrons_emitted: int or float - number of neutrons emitted per second.
    :return: bool - is criticality balanced?

    A reactor is said to be critical if it satisfies the following conditions:
    - The temperature is less than 800 K.
    - The number of neutrons emitted per second is greater than 500.
    - The product of temperature and neutrons emitted per second is less than 500_000.
    """
    return temperature < 800 and neutrons_emitted > 500 and temperature * neutrons_emitted < 500_000


def get_efficiency_rate(
    voltage: Union[int, float], current: Union[int, float], theoretical_max_power: Union[int, float]
) -> float:
    """Assess reactor efficiency zone.

    :param voltage: int or float - voltage value.
    :param current: int or float - current value.
    :param theoretical_max_power: int or float - power that corresponds to a 100% efficiency.
    :return: float - power efficiency rate

    The efficiency percentage value is calculated as
        (generated power/ theoretical max power)*100
    where generated power = voltage * current
    """
    power: Union[int, float] = voltage * current
    return round((power / theoretical_max_power) * 100, 1)


def reactor_efficiency(
    voltage: Union[int, float], current: Union[int, float], theoretical_max_power: Union[int, float]
) -> str:
    """Assess reactor efficiency zone.

    :param voltage: int or float - voltage value.
    :param current: int or float - current value.
    :param theoretical_max_power: int or float - power that corresponds to a 100% efficiency.
    :return: str - one of ('green', 'orange', 'red', or 'black').

    Efficiency can be grouped into 4 bands:

    1. green -> efficiency of 80% or more,
    2. orange -> efficiency of less than 80% but at least 60%,
    3. red -> efficiency below 60%, but still 30% or more,
    4. black ->  less than 30% efficient.
    """
    efficiency_rate: float = get_efficiency_rate(voltage, current, theoretical_max_power)

    match efficiency_rate:
        case _ if efficiency_rate >= 80:
            return "green"
        case _ if efficiency_rate >= 60:
            return "orange"
        case _ if efficiency_rate >= 30:
            return "red"
        case _:
            return "black"


def get_energy_output(temperature: Union[int, float], neutrons_produced_per_second: Union[int, float]) -> float:
    """Assess reactor energy output.

    :param temperature: int or float - value of the temperature in kelvin.
    :param neutrons_produced_per_second: int or float - neutron flux.
    :return: float - energy output

    The enery output value is calculated as
        temperature * neutrons_produced_per_second
    """
    return round(float(temperature * neutrons_produced_per_second), 0)


def fail_safe(
    temperature: Union[int, float], neutrons_produced_per_second: Union[int, float], threshold: Union[int, float]
) -> str:
    """Assess and return status code for the reactor.

    :param temperature: int or float - value of the temperature in kelvin.
    :param neutrons_produced_per_second: int or float - neutron flux.
    :param threshold: int or float - threshold for category.
    :return: str - one of ('LOW', 'NORMAL', 'DANGER').

    1. 'LOW' -> `temperature * neutrons per second` < 90% of `threshold`
    2. 'NORMAL' -> `temperature * neutrons per second` +/- 10% of `threshold`
    3. 'DANGER' -> `temperature * neutrons per second` is not in the above-stated ranges
    """
    energy_output: float = get_energy_output(temperature, neutrons_produced_per_second)

    safety_rating: float = energy_output / threshold * 100.0

    match safety_rating:
        case _ if safety_rating < 90:
            return "LOW"
        case _ if safety_rating >= 90 and safety_rating <= 110:
            return "NORMAL"
        case _:
            return "DANGER"
