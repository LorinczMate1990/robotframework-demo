from robot.api import logger

class Pylabry:
    def __init__(self, id):
        self.id = id
        logger.console(f"Pylabry '{self.id}' is inited")

    def __del__(self):
        logger.console(f"Pylabry '{self.id}' is killed")

    def this_is_a_keyword(self):
        logger.console(f"this keyword from '{self.id}' which is implemented in python")
