define ;Header and description

(define (domain droneRescueDomaincopy)

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
        :parameters (?d - location ?person - person ?drone - drone ?m - number ?n - number)
        :precondition (and
            (drone-full ?drone) ;; The drone is full with a person
            (not (rescued ?person)) ;; The person has not been rescued yet
            (safe-zone ?d) ;; The drone is at the safe zone location
            (safe-zone-has-space ?m) ;; The safe zone has room for people
            (at ?drone ?d) ;; The drone is at the safe zone
            (picked ?person) ;; The person has been picked up
            (< ?m (- ?n 1)) ;; The safe zone can hold (n-1) people, dynamically calculated
        )
        :effect (and
            (rescued ?person) ;; The person is now rescued
            (not (picked ?person)) ;; The person is no longer in the drone
            (drone-empty ?drone) ;; The drone becomes empty
            (increase (safe-zone-capacity) 1) ;; Increase the count of people in the safe zone
            (when
                (forall
                    (?p - person)
                    (rescued ?p)) ;; When all people are rescued
                (all-people-rescued)) ;; Set a flag indicating all people are rescued
        )
    )

    (:action return-to-rest
        :parameters (?drone ?current ?rest)
        :precondition (and (drone ?current) (adjacent ?current ?rest) (drone-rest-zone ?rest) (drone-empty)
            (or (safe-zone-full) (all-people-rescued)))
        :effect (and (drone ?rest) (not (drone ?current)) (blank-space ?current))
    )

)