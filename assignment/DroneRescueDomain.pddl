define ;Header and description

(define (domain droneRescueDomain)

    ;remove requirements that are not needed
    (:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

    (:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
        )

    ; un-comment following line if constants are needed
    ;(:constants )

    (:predicates
        (drone-empty)
        (drone-full)
        (safe-zone-full)
        (drone-rest-zone ?d)
        (safe-zone-capacity-reduced)
        (safe-zone-has-space)
        (blank-space ?d)
        (drone ?d) ; Drone location.
        (person ?d) ; Location d contains a person.
        (obstacle ?d); Location d contains an obstacle.
        (safe-zone ?d); Location d is the designated safe zone.
        (safe-zone-capacity m); The number of people currently in the safe zone is m.
        (adjacent ?d1 ?d2); Locations d1 and d2 are adjacent.
        (rescued ?p); The person has been rescued
        (picked ?p)
        ;todo: define predicates here
    )

    ;Move(d1,d2): The drone moves from location d1 to an adjacent location d2.
    ; Pick-up(person,p): The drone picks up a person stranded at location p.
    ; Drop-off(person,safe_zone): The drone drops off a person at the safe zone, as long as  the capacity allows.
    (:action move
        :parameters (?drone ?d1 ?d2)
        :precondition (and((drone ?d1)(adjacent ?d1 ?d2)
                (not(obstacle ?d2))))
        :effect (and (drone ?d2) not(drone ?d1) (blank-space ?d1))
    )
    (:action pick-up
        :parameters (?person ?d ?drone)
        :precondition (and (person ?d)(drone ?d)(drone-empty) not(rescued ?person) not(picked ?person))
        :effect (and not(person ?d) (drone-full) (blank-space ?d) (picked ?person)
            (when
                (forall
                    (?p - person)
                    (rescued ?p))
                (all-people-rescued)))
    )

    (:action drop-off
        :parameters (?d ?m ?person ?drone) ; we need position and rescued people count
        :precondition (and (drone-full) not(rescued ?person) (safe-zone ?d)(safe-zone-has-space)(drone ?d) not(person ?d) (safe-zone ?d)(picked ?person) not(safe-zone-full) (< ?m (- ?n 1)))
        :effect (and (rescued ?person) not(picked ?person)(drone-empty) (safe-zone-capacity-reduced) (when
                (forall
                    (?p - person)
                    (rescued ?p))
                (all-people-rescued)))
    )

    (:action return-to-rest
        :parameters (?drone ?current ?rest)
        :precondition (and (drone ?current) (adjacent ?current ?rest) (drone-rest-zone ?rest) (drone-empty)
            (or (safe-zone-full) (all-people-rescued)))
        :effect (and (drone ?rest) (not (drone ?current)) (blank-space ?current))
    )

)