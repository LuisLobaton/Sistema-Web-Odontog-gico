
package main

import rego.v1

# Rechazar SSH TCP (puerto 22) abierto a Internet.
deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_security_group"
    rc.change.after != null

    some rule in rc.change.after.ingress
    rule.protocol == "tcp"
    rule.from_port <= 22
    rule.to_port >= 22
    "0.0.0.0/0" in object.get(rule, "cidr_blocks", [])

    msg := sprintf(
        "SSH abierto a Internet en el recurso %s",
        [rc.address]
    )
}

# Rechazar reglas que permiten todo el tráfico desde Internet.
deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_security_group"
    rc.change.after != null

    some rule in rc.change.after.ingress
    rule.protocol == "-1"
    "0.0.0.0/0" in object.get(rule, "cidr_blocks", [])

    msg := sprintf(
        "Todo el tráfico está permitido desde Internet en %s",
        [rc.address]
    )
}
